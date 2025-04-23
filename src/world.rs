/// Utilities for interacting with and obtaining information from the World.
use std::{
    collections::HashMap,
    fs::{self, File},
    io::{self, Error, Read},
    path::{self, Path, PathBuf},
    process::Command,
};

use tracing::{Level, event};

use crate::site::{RouteNode, RouteTree, Routes, Site, Templater};

impl TypstDoc {
    pub fn new(path_to_html: &Path) -> Result<TypstDoc, std::io::Error> {
        let doc = TypstDoc {
            source_path: path_to_html.to_path_buf(),
        };

        Ok(doc)
    }
}

/// A representation of a Typst source file. In the future, it will contain metadata from files.
#[derive(Debug, Clone)]
pub struct TypstDoc {
    source_path: PathBuf,
}

/// Given a path to an entry point `main.typ` and an output location, use the Typst CLI to compile
/// an HTML artifact. Requires `typst` to be in `$PATH`. The directory of the output must exist or
/// an error will occur.
pub fn compile_document(
    input: &path::Path,
    output: &path::Path,
    root: &path::Path,
) -> Result<(), Error> {
    let resolved_document = input.canonicalize()?;
    if let Some(dir) = output.parent() {
        if !dir.exists() {
            return Err(Error::new(
                std::io::ErrorKind::Other,
                "Directory doesn't exist.",
            ));
        }
    }

    let mut typst = Command::new("typst")
        .arg("compile")
        .args(["--features", "html"])
        .args(["--format", "html"])
        .args([
            "--root",
            root.to_str().expect("could not cast root dir to a string."),
        ])
        .arg(
            resolved_document
                .to_str()
                .expect("Failed to cast document to a string."),
        )
        .arg(
            output
                .to_str()
                .expect("Failed to cast output path to a string."),
        )
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
            panic!();
        }
    }
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

/// Utilities for `.luminite` and `dist`
impl WorkingDirs {
    /// Set up the working directories, `dist` for built artifacts and `.luminite` for intermediate
    /// artifacts, as well as intermediate directories.
    fn setup_working_dirs() -> Result<WorkingDirs, Error> {
        let dist_path = Path::new("./dist");
        let factory_path = Path::new("./.luminite");
        if std::fs::exists(dist_path)? {
            std::fs::remove_dir_all(dist_path)?;
        }
        if std::fs::exists(factory_path)? {
            std::fs::remove_dir_all(factory_path)?;
        }
        std::fs::create_dir_all("./dist")?;
        std::fs::create_dir_all("./.luminite")?;
        Ok(WorkingDirs {
            dist: dist_path.to_path_buf(),
            factory: factory_path.to_path_buf(),
        })
    }

    pub fn working_dirs_exist() -> Result<bool, Error> {
        let dist_path = Path::new("./dist");
        let factory_path = Path::new("./.luminite");

        Ok(std::fs::exists(dist_path)?
            && std::fs::exists(factory_path)?
            && dist_path.is_dir()
            && factory_path.is_dir())
    }

    /// Guarantees that the working directories exist and returns their `PathBuf`s.
    pub fn get_dirs() -> Result<WorkingDirs, Error> {
        if !WorkingDirs::working_dirs_exist()? {
            return WorkingDirs::setup_working_dirs();
        }

        let dist_path = Path::new("./dist");
        let factory_path = Path::new("./.luminite");

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
    _realized: bool,
    root: PathBuf,
}

impl World {
    pub fn new(working_dirs: WorkingDirs) -> World {
        World {
            working_dirs,
            _realized: false,
            root: PathBuf::from("./"),
        }
    }

    /// Given a `TypstDoc`, build it in the World and return a path to it (which is guaranteed to
    /// exist).
    fn build_doc(&self, doc: &TypstDoc) -> Result<PathBuf, Error> {
        let dirs = &self.working_dirs;
        let mut html_artifacts_path = dirs.factory.clone();
        html_artifacts_path.push(Path::new("./typst-html"));

        if html_artifacts_path.is_dir() || std::fs::exists(&html_artifacts_path)? {
            std::fs::remove_dir_all(&html_artifacts_path)?;
        }

        std::fs::create_dir(&html_artifacts_path)?;
        let output_path = html_artifacts_path.join(PathBuf::from(format!(
            "./{}.html",
            doc.source_path.file_stem().unwrap().to_str().unwrap()
        )));
        compile_document(&doc.source_path, &output_path, &self.root)?;

        Ok(output_path)
    }

    /// Given a `TypstDoc`, realize it in the World and obtain its contents, with <DOCTYPE>,
    /// <html>, <head>, and <body> tags truncated.
    pub fn get_doc_contents(&self, doc: &TypstDoc) -> Result<String, Error> {
        let build_path = self
            .build_doc(doc)
            .expect("Something went wrong building a document.");

        let mut file = std::fs::File::open(build_path)
            .expect("Something has gone wrong opening the contents of a compiled document.");
        let mut contents = String::new();
        file.read_to_string(&mut contents).unwrap();
        let truncated_source = truncate_lines(&contents, 7, 2);

        Ok(truncated_source)
    }

    /// Index the `routes` directory in the World, and return a tree representing the raw directory
    /// structure.
    fn index_routes(&self) -> RawRouteTree {
        event!(Level::INFO, "Indexing routes...");
        let routes_dir = self.root.join("./routes");
        if !routes_dir.exists() {
            event!(Level::ERROR, "Routes folder was not found!");
            panic!();
        }
        walk_dirs(&routes_dir)
    }

    /// Get routes from the world.
    pub fn get_routes(&self) -> Routes {
        Routes {
            tree: reconcile_raw_routes(&self.index_routes()),
        }
    }

    /// Given a `&Site`, perform all the necessary actions (e.g. running the Typst compiler,
    /// generating metadata, etc.) and output the artifacts in `dist`.
    fn build_routes(&self, site: &Site) -> Result<(), Error> {
        self.route_builder_helper(&site.routes.tree, "".to_string(), &site.templater)?;
        Ok(())
    }

    fn copy_public_dir(&self, site: &Site) -> Result<(), Error> {
        if !site.public_dir.exists() {
            event!(Level::ERROR, "The public directory doesn't exist!");
            panic!();
        }

        event!(Level::INFO, "Copying assets over from public/");

        dircpy::CopyBuilder::new(
            &site.public_dir,
            self.working_dirs.dist.join(Path::new("./.")),
        )
        .overwrite_if_newer(true)
        .overwrite_if_size_differs(true)
        .run()
        .unwrap();

        Ok(())
    }

    pub fn realize_site(&self, site: &Site) -> Result<(), Error> {
        self.copy_public_dir(site)?;
        self.build_routes(site)?;

        Ok(())
    }

    /// Helper function to recursively traverse a tree of routes for implementing `build_site`.
    /// Renders each document and applies the template rule.
    fn route_builder_helper(
        &self,
        routes: &RouteTree,
        parent_route: String,
        templater: &Templater,
    ) -> Result<(), Error> {
        for node in routes.iter() {
            match node {
                (slug, RouteNode::Page(doc)) => {
                    let output_route = match slug.as_str() {
                        "index" => parent_route.clone() + "/",
                        _ => parent_route.clone() + "/" + slug,
                    };

                    event!(Level::INFO, "Compiling {}.", output_route.as_str());

                    let contents = self.get_doc_contents(doc)?;
                    let rendered = templater(output_route.clone(), contents);
                    let target_path = match output_route.as_str() {
                        "/" => self.working_dirs.dist.join(PathBuf::from(
                            output_route.trim_start_matches("/").to_owned() + "./index",
                        )),
                        _ => self
                            .working_dirs
                            .dist
                            .join(PathBuf::from(output_route.trim_start_matches("/"))),
                    }
                    .with_extension("html");

                    create_file_resilient(&target_path)?;
                    std::fs::write(target_path, rendered.as_str())?;
                }
                (slug, RouteNode::Nested(nested_tree)) => {
                    self.route_builder_helper(
                        nested_tree,
                        parent_route.clone() + "/" + slug,
                        templater,
                    )?;
                }
            }
        }
        Ok(())
    }
}

/// Takes the raw tree structure of the routes directory and walks through it, throwing away
/// anything that isn't a route, and turning page nodes into valid `TypstDoc` objects.
fn reconcile_raw_routes(tree: &RawRouteTree) -> RouteTree {
    let mut new_tree: RouteTree = RouteTree::new();

    for node in tree.iter() {
        match node {
            (filename, RawRouteNode::Dir(dir)) => {
                let nested_node = reconcile_raw_routes(dir);
                if !nested_node.is_empty() {
                    new_tree.insert(
                        filename.clone(),
                        RouteNode::Nested(reconcile_raw_routes(dir)),
                    );
                }
            }
            (filename, RawRouteNode::File(file)) => {
                if file.extension().is_some_and(|ext| ext == "typ") && filename.starts_with('+') {
                    new_tree.insert(
                        filename.strip_prefix("+").unwrap().to_string(),
                        RouteNode::Page(
                            TypstDoc::new(file).expect("Error failed parsing routes tree."),
                        ),
                    );
                }
            }
        }
    }

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
fn walk_dirs(dir: &Path) -> RawRouteTree {
    let mut tree: HashMap<String, RawRouteNode> = HashMap::new();
    for entry in dir
        .read_dir()
        .expect("Error while walking routes: the directory doesn't exist!")
        .flatten()
    {
        let path = entry.path();
        if path.is_dir() {
            tree.insert(
                path.file_stem()
                    .unwrap()
                    .to_ascii_lowercase()
                    .to_str()
                    .unwrap()
                    .to_string(),
                RawRouteNode::Dir(walk_dirs(&path)),
            );
        } else {
            tree.insert(
                path.file_stem()
                    .unwrap()
                    .to_ascii_lowercase()
                    .to_str()
                    .unwrap()
                    .to_string(),
                RawRouteNode::File(path.canonicalize().unwrap()),
            );
        }
    }
    tree
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
