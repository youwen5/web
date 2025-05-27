/// Utilities for interacting with and obtaining information from the World.
use std::{
    collections::HashMap,
    fs::{self, File},
    hash::{Hash, Hasher},
    io::{self, Read},
    path::{self, Path, PathBuf},
    process::Command,
};

use minify_html_onepass::{Cfg, Error as HtmlError, in_place_str};
use rayon::iter::{IntoParallelRefIterator, IntoParallelRefMutIterator, ParallelIterator};
use serde::{Deserialize, Serialize};
use thiserror::Error;
use time::OffsetDateTime;
use tracing::{Level, event};

use crate::{
    site::{RouteNode, RouteTree, Routes, Site, Templater},
    templating::create_redirect_page,
};

impl TypstDoc {
    pub fn new(path_to_html: &Path) -> Result<TypstDoc, WorldError> {
        let doc = TypstDoc {
            source_path: path_to_html.to_path_buf(),
            metadata: None,
            artifact_path: None,
        };

        Ok(doc)
    }
}

#[derive(Error, Debug)]
pub enum WorldError {
    #[error("extracting metadata from document produced no result or invalid result")]
    TypstQuery,
    #[error("io error")]
    Io(#[from] io::Error),
    #[error("json deserialization error")]
    JsonDeserialize(#[from] serde_json::Error),
    #[error("failed to build Typst binary")]
    TypstBuild,
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "kebab-case")]
pub struct Metadata {
    /// If the author is not Youwen, then specify another.
    pub special_author: Option<String>,
    pub location: Option<String>,
    #[serde(with = "time::serde::rfc3339::option")]
    pub date: Option<OffsetDateTime>,
    pub title: Option<String>,
    /// Will be displayed under the title in a subheading
    pub subtitle: Option<String>,
    /// Description for metadata purposes (search engines, etc), will not be displayed on site
    /// itself
    pub meta_description: Option<String>,
    /// Short description of content e.g. tagline for display
    pub short_description: Option<String>,
    #[serde(default)]
    pub enable_comments: bool,
    /// Whether to also compile the document as a PDF alongside
    #[serde(default)]
    pub also_compile_pdf: bool,
    /// The filename for the PDF. If not specified, then the web path will be used by default
    pub pdf_filename: Option<String>,
    /// Image thumbnail for the page
    pub thumbnail: Option<String>,
}

/// A data representation of a Typst source file. The way our build step works is in two parts:
/// first, we will crawl the filesystem and obtain a representation of our site as a `RouteTree`
/// containing `TypstDoc` objects, without `metadata` or `artifact_path` populated. Then, we
/// traverse the tree and query every single document for metadata, populating the field. At this
/// point we have all the information about the website, and we can do any intermediate
/// transformations. Next, we build each `TypstDoc` into an actual HTML artifact in a temporary
/// working directory (`.epilogue/typst-html`), populating the `artifact_path`. Finally, we can
/// actually build the website, reading the built HTML in `artifact_path` and injecting it into
/// templates, etc.
#[derive(Debug)]
pub struct TypstDoc {
    /// The original path of the Typst source code
    source_path: PathBuf,
    /// The metadata associated with document, typically extracted using `World::get_metadata()`
    pub metadata: Option<Metadata>,
    /// The path to the built HTML artifact associated with the document
    artifact_path: Option<PathBuf>,
}

/// Given a path to an entry point `main.typ` and an output location, use the Typst CLI to compile
/// an PDF to the output path. Requires `typst` to be in `$PATH`. The parent directory of the
/// output must exist or an error will occur.
/// TODO: better handle errors, throw when typst exits with error code.
fn compile_document(
    input: &path::Path,
    output: &path::Path,
    root: &path::Path,
) -> Result<(), WorldError> {
    let resolved_document = input.canonicalize()?;
    if let Some(dir) = output.parent() {
        if !dir.exists() {
            return Err(WorldError::Io(std::io::Error::new(
                std::io::ErrorKind::NotFound,
                "output dir doesn’t exist",
            )));
        }

        match dir.try_exists() {
            Ok(exists) => {
                if !exists {
                    event!(Level::ERROR, "Outputs directory was not found!");
                    return Err(WorldError::Io(io::Error::new(
                        io::ErrorKind::NotFound,
                        "target directory does not exist",
                    )));
                }
            }
            Err(error) => return Err(WorldError::Io(error)),
        }
    }

    let mut typst = Command::new("typst")
        .arg("compile")
        .args(["--features", "html"])
        .args(["--format", "html"])
        .args([
            "--root",
            root.to_str().ok_or(std::io::Error::new(
                std::io::ErrorKind::InvalidData,
                "could not parse build root to valid UTF-8",
            ))?,
        ])
        .arg(resolved_document.to_str().ok_or(std::io::Error::new(
            std::io::ErrorKind::InvalidData,
            "could not parse document path to valid UTF-8",
        ))?)
        .arg(output.to_str().ok_or(std::io::Error::new(
            std::io::ErrorKind::InvalidData,
            "could not parse output path to valid UTF-8",
        ))?)
        .spawn()?;

    match typst.wait() {
        Ok(_) => Ok(()),
        Err(err) => {
            event!(
                Level::ERROR,
                "Tried to compile {}, but I failed with the error {}. Are you sure that Typst is in $PATH?",
                input.to_str().unwrap(),
                err,
            );
            Err(WorldError::Io(err))
        }
    }
}

/// Given a path to an entry point `main.typ` and an output location, use the Typst CLI to compile
/// an HTML artifact. Requires `typst` to be in `$PATH`. The directory of the output must exist or
/// an error will occur.
fn compile_pdf(
    input: &path::Path,
    output: &path::Path,
    root: &path::Path,
) -> Result<(), WorldError> {
    let resolved_document = input.canonicalize()?;
    if let Some(dir) = output.parent() {
        if !dir.exists() {
            return Err(WorldError::Io(std::io::Error::new(
                std::io::ErrorKind::NotFound,
                "output dir doesn’t exist",
            )));
        }

        match dir.try_exists() {
            Ok(exists) => {
                if !exists {
                    event!(Level::ERROR, "Outputs directory was not found!");
                    return Err(WorldError::Io(io::Error::new(
                        io::ErrorKind::NotFound,
                        "target directory does not exist",
                    )));
                }
            }
            Err(error) => return Err(WorldError::Io(error)),
        }
    }

    let mut typst = Command::new("typst")
        .arg("compile")
        .args(["--features", "html"])
        .args(["--format", "pdf"])
        .args([
            "--root",
            root.to_str().ok_or(std::io::Error::new(
                std::io::ErrorKind::InvalidData,
                "could not parse build root to valid UTF-8",
            ))?,
        ])
        .arg(resolved_document.to_str().ok_or(std::io::Error::new(
            std::io::ErrorKind::InvalidData,
            "could not parse document path to valid UTF-8",
        ))?)
        .arg(output.to_str().ok_or(std::io::Error::new(
            std::io::ErrorKind::InvalidData,
            "could not parse output path to valid UTF-8",
        ))?)
        .spawn()?;

    match typst.wait() {
        Ok(_) => Ok(()),
        Err(err) => {
            event!(
                Level::ERROR,
                "Tried to compile {}, but I failed with the error {}. Are you sure that Typst is in $PATH?",
                input.to_str().unwrap(),
                err,
            );
            Err(WorldError::Io(err))
        }
    }
}

/// Use the Typst CLI to query a document for its metadata.
fn query_metadata(path: &Path, root: &Path) -> Result<Metadata, WorldError> {
    let output = Command::new("typst")
        .arg("query")
        .args(["--features", "html"])
        .args(["--field", "value"])
        .arg("--one")
        .args(["--format", "json"])
        .args([
            "--root",
            root.to_str().expect("could not cast root dir to a string."),
        ])
        .arg(path.to_str().expect("Failed to cast document to a string."))
        .arg("<metadata>")
        .output()?;

    let value = if output.status.success() {
        String::from_utf8(output.stdout)
    } else {
        event!(
            Level::ERROR,
            "Query fail: {:?}",
            String::from_utf8(output.stderr)
                .unwrap_or("failed to convert stderr bytes to string".into())
        );
        return Err(WorldError::TypstQuery);
    };

    let value = match value {
        Ok(str) => {
            if str.is_empty() || str == "null" {
                return Err(WorldError::TypstQuery);
            } else {
                str
            }
        }
        Err(error) => {
            event!(
                Level::ERROR,
                "Failed to convert UTF-8 string while parsing metadata for {:?}, with error: {error}.",
                path.as_os_str()
            );

            panic!();
        }
    };

    Ok(serde_json::from_str(&value)?)
}

fn create_file_resilient<P: AsRef<Path>>(path: P) -> io::Result<File> {
    let path = path.as_ref();

    if let Some(parent_dir) = path.parent() {
        fs::create_dir_all(parent_dir)?;
    }

    let file = File::create(path)?;

    Ok(file)
}

pub struct WorkingDirs {
    dist: PathBuf,
    factory: PathBuf,
}

/// Utilities for `.epilogue` and `dist`
impl WorkingDirs {
    /// Set up the working directories, `dist` for built artifacts and `.epilogue` for intermediate
    /// artifacts, as well as intermediate directories.
    fn setup_working_dirs() -> Result<WorkingDirs, WorldError> {
        let dist_path = Path::new("./dist");
        let factory_path = Path::new("./.epilogue");
        if std::fs::exists(dist_path)? {
            std::fs::remove_dir_all(dist_path)?;
        }
        if std::fs::exists(factory_path)? {
            std::fs::remove_dir_all(factory_path)?;
        }
        std::fs::create_dir_all("./dist")?;
        std::fs::create_dir_all("./.epilogue")?;
        Ok(WorkingDirs {
            dist: dist_path.to_path_buf(),
            factory: factory_path.to_path_buf(),
        })
    }

    /// Whether or not the working directories exist already. Says nothing about whether they’re
    /// actually valid
    pub fn working_dirs_exist() -> Result<bool, WorldError> {
        let dist_path = Path::new("./dist");
        let factory_path = Path::new("./.epilogue");

        Ok(std::fs::exists(dist_path)?
            && std::fs::exists(factory_path)?
            && dist_path.is_dir()
            && factory_path.is_dir())
    }

    /// Guarantees that the working directories exist and returns their `PathBuf`s.
    pub fn get_dirs() -> Result<WorkingDirs, WorldError> {
        if !WorkingDirs::working_dirs_exist()? {
            return WorkingDirs::setup_working_dirs();
        }

        let dist_path = Path::new("./dist");
        let factory_path = Path::new("./.epilogue");

        Ok(WorkingDirs {
            dist: dist_path.to_path_buf(),
            factory: factory_path.to_path_buf(),
        })
    }
}

/// Abstracts away the World we are interacting with. If the world is _realized_, that means
/// all files have been generated and paths are guaranteed to be valid.
pub struct World {
    working_dirs: WorkingDirs,
    root: PathBuf,
}

impl World {
    /// Create a new World from a set of working_dirs, taking ownership
    pub fn from(working_dirs: WorkingDirs) -> World {
        World {
            working_dirs,
            root: PathBuf::from("./"),
        }
    }

    /// Given a `TypstDoc`, build it in the World and populate its `artifact_path` with the built
    /// document.
    fn build_doc(&self, doc: &mut TypstDoc, html_artifacts_path: &Path) -> Result<(), WorldError> {
        let mut s = std::hash::DefaultHasher::new();
        doc.source_path.as_os_str().hash(&mut s);

        let output_path = html_artifacts_path.join(PathBuf::from(format!(
            "./{}-{}.html",
            doc.source_path.file_stem().unwrap().to_str().unwrap(),
            s.finish()
        )));
        compile_document(&doc.source_path, &output_path, &self.root)?;

        doc.artifact_path = Some(output_path);

        Ok(())
    }

    /// Given a `TypstDoc`, realize it in the World and obtain its contents, with \<DOCTYPE>,
    /// \<html>, \<head>, and \<body> tags truncated.
    pub fn get_doc_contents(&self, doc: &mut TypstDoc) -> Result<String, WorldError> {
        let mut file = std::fs::File::open(
            doc.artifact_path
                .take()
                .expect("there should be a document here")
                .as_os_str(),
        )
        .expect("Something has gone wrong opening the contents of a compiled document.");

        let mut contents = String::new();
        file.read_to_string(&mut contents).unwrap();
        let truncated_source = truncate_lines(&contents, 7, 2);

        Ok(truncated_source)
    }

    /// Index the `routes` directory in the World, and return a tree representing the raw directory
    /// structure.
    fn index_routes(&self) -> Result<RawRouteTree, WorldError> {
        event!(Level::INFO, "Indexing routes...");
        let routes_dir = self.root.join("./routes");
        match routes_dir.try_exists() {
            Ok(exists) => {
                if !exists {
                    event!(Level::ERROR, "Routes directory was not found!");
                    return Err(WorldError::Io(io::Error::new(
                        io::ErrorKind::NotFound,
                        "target directory does not exist",
                    )));
                }
            }
            Err(error) => return Err(WorldError::Io(error)),
        }
        walk_dirs(&routes_dir)
    }

    /// Get routes from the world.
    pub fn get_routes(&self) -> Result<Routes, WorldError> {
        Ok(Routes {
            tree: reconcile_raw_routes(&self.index_routes()?),
        })
    }

    /// Given a `&Site`, perform all the necessary actions (e.g. running the Typst compiler,
    /// generating metadata, etc.) and output the artifacts in `dist`. It may consume various parts
    /// of `&Site`, so `&Site` should be dropped immediately after this is called.
    fn build_routes(&self, site: &mut Site, minify: bool) -> Result<(), WorldError> {
        let dirs = &self.working_dirs;
        let mut html_artifacts_path = dirs.factory.to_owned();
        html_artifacts_path.push(Path::new("./typst-html"));

        if !html_artifacts_path.is_dir() || !std::fs::exists(&html_artifacts_path)? {
            std::fs::create_dir(&html_artifacts_path)?;
        }

        self.build_artifacts(&mut site.routes.tree, &html_artifacts_path)?;

        self.build_templates(
            &mut site.routes.tree,
            "".to_string(),
            &site.templater,
            minify,
        )?;
        Ok(())
    }

    fn copy_public_dir(&self, site: &Site) -> Result<(), WorldError> {
        match site.public_dir.try_exists() {
            Ok(exists) => {
                if !exists {
                    event!(Level::INFO, "Copying assets over from public/");
                    return Err(WorldError::Io(io::Error::new(
                        io::ErrorKind::NotFound,
                        "target directory does not exist",
                    )));
                }
            }
            Err(error) => return Err(WorldError::Io(error)),
        };

        dircpy::CopyBuilder::new(
            &site.public_dir,
            self.working_dirs.dist.join(Path::new("./.")),
        )
        .overwrite_if_newer(true)
        .overwrite_if_size_differs(true)
        .run()?;

        Ok(())
    }

    /// Build all the artifacts for a `RouteTree`, populating each `TypstDoc` with the
    /// `artifact_path`.
    fn build_artifacts(
        &self,
        route_tree: &mut RouteTree,
        html_artifacts_path: &Path,
    ) -> Result<(), WorldError> {
        route_tree
            .par_iter_mut()
            .try_for_each(|(filename, node)| match node {
                RouteNode::Page(typst_doc) => {
                    event!(Level::INFO, "Building artifact for {}", filename);

                    self.build_doc(typst_doc, html_artifacts_path)?;

                    event!(
                        Level::DEBUG,
                        "Built an HTML artifact from {filename}, at path {:?}",
                        typst_doc.source_path.as_os_str(),
                    );

                    Ok(())
                }
                RouteNode::Nested(hash_map) => self.build_artifacts(hash_map, html_artifacts_path),
                RouteNode::Redirect(_) => Ok(()),
            })
    }

    /// Helper function to recursively traverse a tree of routes for implementing `build_site`.
    /// Renders each document and applies the template rule.
    fn build_templates(
        &self,
        routes: &mut RouteTree,
        parent_route: String,
        templater: &Templater,
        minify: bool,
    ) -> Result<(), WorldError> {
        for node in routes.iter_mut() {
            match node {
                (slug, RouteNode::Redirect(path)) => {
                    let output_route = match slug.as_str() {
                        "index" => parent_route.to_owned() + "/",
                        _ => parent_route.to_owned() + "/" + slug,
                    };

                    let target_path = match output_route.as_str() {
                        "/" => self.working_dirs.dist.join(PathBuf::from(
                            output_route.trim_start_matches("/").to_owned() + "./index",
                        )),
                        _ => self
                            .working_dirs
                            .dist
                            .join(PathBuf::from(output_route.trim_start_matches("/"))),
                    };

                    let html_path = target_path.with_extension("html");
                    let target_path = fs::read_to_string(path)?;
                    let redirect_template = create_redirect_page(&target_path);

                    event!(
                        Level::INFO,
                        "Creating a redirect from {output_route} to {target_path}"
                    );
                    create_file_resilient(&html_path)?;
                    std::fs::write(&html_path, redirect_template.as_str())?;
                }
                (slug, RouteNode::Page(doc)) => {
                    let output_route = match slug.as_str() {
                        "index" => parent_route.to_owned() + "/",
                        _ => parent_route.to_owned() + "/" + slug,
                    };

                    let minify_cfg = &Cfg {
                        minify_js: true,
                        minify_css: true,
                    };

                    event!(
                        Level::INFO,
                        "Creating webpage at {}.",
                        output_route.as_str()
                    );

                    let contents = self.get_doc_contents(doc)?;
                    let metadata = doc.metadata.as_ref().expect("no metadata in document");
                    let should_compile_pdf = metadata.also_compile_pdf;

                    let target_path = match output_route.as_str() {
                        "/" => self.working_dirs.dist.join(PathBuf::from(
                            output_route.trim_start_matches("/").to_owned() + "./index",
                        )),
                        _ => self
                            .working_dirs
                            .dist
                            .join(PathBuf::from(output_route.trim_start_matches("/"))),
                    };

                    let pdf_path = match &metadata.pdf_filename {
                        Some(filename) => match target_path.parent() {
                            Some(parent) => parent.join(filename).with_extension("pdf"),
                            None => target_path.join(filename).with_extension("pdf"),
                        },
                        None => target_path.with_extension("pdf"),
                    };

                    // let the templater consume the metadata.
                    let rendered = templater(
                        output_route.to_owned(),
                        contents,
                        doc.metadata.take().expect("no metadata in document"),
                    );
                    let mut rendered = rendered.as_str().to_string();
                    let rendered = if minify {
                        match in_place_str(&mut rendered, minify_cfg) {
                            Ok(minified) => minified,
                            Err(HtmlError {
                                error_type,
                                position,
                            }) => {
                                event!(
                                    Level::WARN,
                                    "Failed to minify HTML while parsing the file {:?}, with error {:?} at position {position}.",
                                    &doc.source_path.as_os_str(),
                                    error_type,
                                );
                                &rendered
                            }
                        }
                    } else {
                        &rendered
                    };

                    let html_path = target_path.with_extension("html");

                    create_file_resilient(&html_path)?;
                    std::fs::write(&html_path, rendered)?;

                    if should_compile_pdf {
                        event!(
                            Level::INFO,
                            "Building a PDF for {:?}, at {:?}",
                            html_path.as_os_str(),
                            pdf_path.as_os_str()
                        );
                        create_file_resilient(&pdf_path)?;
                        compile_pdf(&doc.source_path, &pdf_path, &self.root)?;
                    }
                }
                (slug, RouteNode::Nested(nested_tree)) => {
                    self.build_templates(
                        nested_tree,
                        parent_route.to_owned() + "/" + slug,
                        templater,
                        minify,
                    )?;
                }
            }
        }
        Ok(())
    }

    /// Given a site, extract the metadata from each document.
    pub fn get_metadata(&self, site: &mut Site) -> std::result::Result<(), WorldError> {
        self.get_metadata_helper(&mut site.routes.tree)
    }

    /// Helper to recursively traverse the route tree and query metadata in parallel.
    fn get_metadata_helper(&self, route_tree: &mut RouteTree) -> Result<(), WorldError> {
        route_tree
            .par_iter_mut()
            .try_for_each(|(filename, node)| match node {
                RouteNode::Page(typst_doc) => {
                    let metadata = query_metadata(&typst_doc.source_path, &self.root)?;

                    event!(
                        Level::DEBUG,
                        "Queried metadata from {filename}, at path {:?}",
                        typst_doc.source_path.as_os_str(),
                    );
                    event!(Level::INFO, "Grabbing metadata from {}", filename);

                    typst_doc.metadata = Some(metadata);

                    Ok(())
                }
                RouteNode::Nested(hash_map) => self.get_metadata_helper(hash_map),
                RouteNode::Redirect(_) => Ok(()),
            })
    }

    fn cleanup(&self) -> Result<(), WorldError> {
        let html_dir = self.working_dirs.factory.join("typst-html");
        if html_dir.try_exists()? {
            std::fs::remove_dir_all(self.working_dirs.factory.join("typst-html"))?;
        }
        Ok(())
    }

    pub fn realize_site(&self, mut site: Site, minify: bool) -> Result<(), WorldError> {
        self.cleanup()?;
        self.copy_public_dir(&site)?;
        self.get_metadata(&mut site)?;
        self.build_routes(&mut site, minify)?;

        Ok(())
    }
}

/// Takes the raw tree structure of the routes directory and walks through it, throwing away
/// anything that isn’t a route, and turning page nodes into valid `TypstDoc` objects.
fn reconcile_raw_routes(tree: &RawRouteTree) -> RouteTree {
    let new_tree: RouteTree = tree
        .par_iter()
        .filter_map(|(filename, node_value)| match node_value {
            RawRouteNode::Dir(dir) => {
                let nested_node = reconcile_raw_routes(dir);
                if !nested_node.is_empty() {
                    Some((filename.to_owned(), RouteNode::Nested(nested_node)))
                } else {
                    None
                }
            }
            RawRouteNode::File(file) => {
                if file.extension().is_none() && filename.starts_with("+redirect__") {
                    let path = filename.trim_start_matches("+redirect__");
                    Some((path.to_string(), RouteNode::Redirect(file.to_path_buf())))
                } else if file.extension().is_some_and(|ext| ext == "typ")
                    && filename.starts_with('+')
                {
                    filename.strip_prefix('+').map(|stripped| {
                        (
                            stripped.to_string(),
                            RouteNode::Page(Box::new(
                                TypstDoc::new(file).expect("Error failed parsing routes tree."),
                            )),
                        )
                    })
                } else {
                    None
                }
            }
        })
        .collect();

    new_tree
}

/// A tree structure representing the `routes` directory.
type RawRouteTree = HashMap<String, RawRouteNode>;

/// A node in `RouteTree`. Either a file or a directory that contains a nested tree.
#[derive(Debug)]
enum RawRouteNode {
    File(PathBuf),
    Dir(RawRouteTree),
}

/// Helper function to recursively walk down the `routes` directory and generate a raw tree
/// representation of it.
fn walk_dirs(dir: &Path) -> Result<RawRouteTree, WorldError> {
    let mut tree: HashMap<String, RawRouteNode> = HashMap::new();
    for entry in dir.read_dir()?.flatten() {
        let path = entry.path();
        if path.is_dir() {
            tree.insert(
                path.file_stem()
                    .unwrap()
                    .to_ascii_lowercase()
                    .to_str()
                    .unwrap()
                    .to_string(),
                RawRouteNode::Dir(walk_dirs(&path)?),
            );
        } else {
            tree.insert(
                path.file_stem()
                    .unwrap()
                    .to_ascii_lowercase()
                    .to_str()
                    .unwrap()
                    .to_string(),
                RawRouteNode::File(path.canonicalize()?),
            );
        }
    }
    Ok(tree)
}

/// Utility function to trim HTML generated by Typst of `<head>`, `<body>` and `<doctype>` tags
fn truncate_lines(content: &str, n_start: usize, n_end: usize) -> String {
    let lines: Vec<&str> = content.lines().collect();

    let total_lines = lines.len();

    if total_lines <= n_start + n_end {
        return String::new();
    }

    let start_index = n_start;
    let end_index = total_lines - n_end;

    let relevant_lines = &lines[start_index..end_index];

    relevant_lines.join("\n")
}
