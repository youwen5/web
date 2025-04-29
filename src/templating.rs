/// Utilities for templating pages
use hypertext::Rendered;

pub trait Template {
    /// Rendering a template consumes the `metadata` object.
    fn render_page_with_content(
        &self,
        content: hypertext::Raw<String>,
        metadata: super::world::Metadata,
    ) -> Rendered<String>;
}
