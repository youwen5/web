/// Utilities for interacting with and obtaining information from the World.
use std::{
    collections::HashMap,
    io::{Error, Read},
    path::{self, Path, PathBuf},
    process::Command,
};

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

    typst.wait().expect("failed to wait on Typst");
    Ok(())
}

pub struct WorkingDirs {
    _dist: PathBuf,
    factory: PathBuf,
}

/// Utilities for `.apogee` and `dist`
impl WorkingDirs {
    /// Set up the working directories, `dist` for built artifacts and `.apogee` for intermediate
    /// artifacts, as well as intermediate directories.
    fn setup_working_dirs() -> Result<WorkingDirs, Error> {
        let dist_path = Path::new("./dist");
        let factory_path = Path::new("./.apogee");
        if std::fs::exists(dist_path)? {
            std::fs::remove_dir_all(dist_path)?;
        }
        if std::fs::exists(factory_path)? {
            std::fs::remove_dir_all(factory_path)?;
        }
        std::fs::create_dir_all("./dist")?;
        std::fs::create_dir_all("./.apogee")?;
        Ok(WorkingDirs {
            _dist: dist_path.to_path_buf(),
            factory: factory_path.to_path_buf(),
        })
    }

    pub fn working_dirs_exist() -> Result<bool, Error> {
        let dist_path = Path::new("./dist");
        let factory_path = Path::new("./.apogee");

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
        let factory_path = Path::new("./.apogee");

        Ok(WorkingDirs {
            _dist: dist_path.to_path_buf(),
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
            .build_doc(&doc)
            .expect("Something went wrong building a document.");

        let mut file = std::fs::File::open(build_path)
            .expect("Something has gone wrong opening the contents of a compiled document.");
        let mut contents = String::new();
        file.read_to_string(&mut contents).unwrap();
        let truncated_source = truncate_lines(&contents, 7, 2);

        Ok(truncated_source)
    }

    /// Index the `routes` directory in the World, and return a tree representing the route
    /// structure.
    fn index_routes(&self) -> RawRouteTree {
        let routes_dir = self.root.join("./routes");
        if !routes_dir.exists() {
            panic!("Routes folder was not found!");
        }
        walk_dirs(&routes_dir)
    }

    pub fn to_routes(&self) -> Routes {
        Routes {
            tree: reconcile_raw_routes(&self.index_routes()),
        }
    }

    pub fn build_site(&self, site: &Site) -> Result<(), Error> {
        self.site_builder_helper(&site.routes.tree, &site.templater)?;
        Ok(())
    }

    fn site_builder_helper(&self, routes: &RouteTree, templater: &Templater) -> Result<(), Error> {
        for node in routes.iter() {
            match node {
                (slug, RouteNode::Page(doc)) => {
                    let contents = self.get_doc_contents(doc)?;
                    templater(slug, contents);
                }
                (slug, RouteNode::Nested(nested_tree)) => {
                    self.site_builder_helper(nested_tree, templater)?;
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
