/// Utilities for templating pages
use hypertext::{Renderable, Rendered, html_elements, maud};

pub trait Template {
    /// Rendering a template consumes the `metadata` object.
    fn render_page_with_content(
        &self,
        content: hypertext::Raw<String>,
        metadata: super::world::Metadata,
    ) -> Rendered<String>;
}

/// Create a barebones html document that simply redirects to `path`
pub fn create_redirect_page(path: &String) -> Rendered<String> {
    maud! {
        !DOCTYPE
        html {
            head {
                meta http-equiv="refresh" content=(format!("0;url={path}"));
                link rel="canonical" href=(path);
            }
            body {
                p {"Redirecting to " (path)}
            }
        }
    }
    .render()
}
