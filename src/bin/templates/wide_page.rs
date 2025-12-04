/// This template is for pages that should fill the full container. Suitable for content that
/// needs more room than the wide margins of prose.
use epilogue::{templating::Template, world::Metadata};
use hypertext::prelude::*;

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
            @if let Some(title) = &metadata.title {
                 h1 class="all-smallcaps md:text-4xl text-center md:text-start text-3xl mt-3" { (title) }
            }
            div id="typst-injected" class="prose-lg lg:prose-xl mt-8 prose-headings:all-smallcaps prose-headings:text-love prose-h1:text-foreground" {
                (content)
            }
        })
    }
}
