use epilogue::{templating::Template, world::Metadata};
use hypertext::{GlobalAttributes, Rendered, html_elements, maud};

use super::{components::Head, default_shell::DefaultShell};

pub struct Index;

impl Template for Index {
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
            div id="typst-injected" class="prose-lg lg:prose-xl mt-2 prose-headings:all-smallcaps prose-headings:text-love prose-h1:text-foreground" {
                @if metadata.title.is_some() {
                     h1 class="text-center md:text-start" {
                         (metadata.title.as_ref().unwrap())
                     }
                }
                (content)
            }
        })
    }
}
