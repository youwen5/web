/// Utilities for templating pages
use hypertext::{GlobalAttributes, Renderable, Rendered, html_elements, maud};

use crate::world::TypstDoc;

pub trait Template {
    fn populate_with_generated_content(&self, content: hypertext::Raw<String>) -> Rendered<String>;
}
