/// Utilities for templating pages
use hypertext::Rendered;

pub trait Template {
    fn render_page_with_content(
        &self,
        content: hypertext::Raw<String>,
        metadata: &super::world::Metadata,
    ) -> Rendered<String>;
}
