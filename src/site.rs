use std::{collections::HashMap, path::PathBuf};

use hypertext::Rendered;

use crate::world::{Metadata, TypstDoc};

pub type RouteTree = HashMap<String, RouteNode>;
#[derive(Debug)]
pub enum RouteNode {
    Page(TypstDoc),
    Nested(RouteTree),
    Redirect(PathBuf),
}

#[derive(Debug)]
pub struct Routes {
    pub tree: RouteTree,
}

/// A templater function, `URL -> TypstContent -> Rendered`. The consumer should implement this
/// function. Given a URL, the function can (optionally) match on it and then render the
/// TypstContent (which a string) into an HTML document (using `maud!`). They should return the
/// `Rendered<String>` which will then be written into the correct place in `dist/`.
pub type Templater = dyn Fn(String, String, Metadata) -> Rendered<String>;

/// Representation of a website. Contains routes, a templater for routes, and describes assets.
pub struct Site {
    /// Routes of the website. Can be generated from the `routes/` directory by
    /// `world::World::get_routes`.
    pub routes: Routes,
    /// A templater function.
    pub templater: Box<Templater>,
    /// Assets which should be copied over verbatim. **WILL BE** overwriten by anything compiled
    /// from templates!
    pub public_dir: PathBuf,
}

impl Site {
    pub fn new<F>(routes: Routes, templater_fn: F) -> Self
    where
        F: Fn(String, String, Metadata) -> Rendered<String> + 'static,
    {
        Site {
            routes,
            templater: Box::new(templater_fn),
            public_dir: PathBuf::from("./public"),
        }
    }
}
