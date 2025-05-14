use hypertext::{GlobalAttributes, Rendered, html_elements, maud};
use luminite::{templating::Template, world::Metadata};

use super::{components::Head, default_shell::DefaultShell};

pub struct Photos;

impl Template for Photos {
    fn render_page_with_content(
        &self,
        content: hypertext::Raw<String>,
        metadata: Metadata,
    ) -> Rendered<String> {
        DefaultShell {
            head: Head::new(&metadata),
            width: super::default_shell::PageWidth::Wide,
        }
        .render_with_children(maud! {
            @if metadata.title.is_some() { h1 class="all-smallcaps md:text-3xl text-2xl text-center mt-4" {(metadata.title.unwrap())} }
            div id="typst-injected" {
                (content)
            }
        })
    }
}
