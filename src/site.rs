use std::collections::HashMap;

use hypertext::Rendered;

use crate::world::TypstDoc;

pub type RouteTree = HashMap<String, RouteNode>;
#[derive(Debug)]
pub enum RouteNode {
    Page(TypstDoc),
    Nested(RouteTree),
}

#[derive(Debug)]
pub struct Routes {
    pub tree: RouteTree,
}

pub type Templater = dyn Fn(&String, String) -> Rendered<String>;

pub struct Site {
    pub routes: Routes,
    pub templater: Box<Templater>,
}

impl Site {
    pub fn new<F>(routes: Routes, templater_fn: F) -> Self
    where
        F: Fn(&String, String) -> Rendered<String> + 'static,
    {
        Site {
            routes,
            templater: Box::new(templater_fn),
        }
    }
}
