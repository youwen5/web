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

pub type TemplateRules = Box<dyn Fn(String, String) -> Rendered<String> + Send + Sync + 'static>;

pub struct Site {
    pub routes: Routes,
    pub templater: String,
}

impl Site {
    pub fn new(routes: Routes, templater: String) -> Site {
        Site { routes, templater }
    }
}
