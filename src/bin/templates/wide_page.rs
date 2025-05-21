/// This template is for pages that should fill the full container. Suitable for content that
/// needs more room than the wide margins of prose.
use epilogue::{templating::Template, world::Metadata};
use hypertext::{GlobalAttributes, Rendered, html_elements, maud};

use super::{components::Head, default_shell::DefaultShell};

pub struct WidePage;

impl Template for WidePage {
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
            @if metadata.title.is_some() {
                 h1 class="all-smallcaps md:text-4xl text-center md:text-start text-3xl mt-3" {
                     (metadata.title.as_ref().unwrap())
                 }
            }
            div id="typst-injected" class="prose-lg lg:prose-xl mt-8 prose-headings:all-smallcaps prose-headings:text-love prose-h1:text-foreground" {
                (content)
            }
        })
    }
}
