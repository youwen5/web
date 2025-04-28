use hypertext::{html_elements, maud, GlobalAttributes, Rendered};
use luminite::{templating::Template, world::Metadata};

use super::{components::Head, default_shell::DefaultShell};

pub struct Prose;

impl Template for Prose {
    fn render_page_with_content(
        &self,
        content: hypertext::Raw<String>,
        metadata: &Metadata,
    ) -> Rendered<String> {
        DefaultShell {
            head: Head {
                page_title: None,
                author: metadata.special_author.clone(),
                description: None,
                image: None,
                meta_title: None,
            },
            width: super::default_shell::PageWidth::Prose,
        }
        .render_with_children(maud! {
            h1 class="all-smallcaps text-3xl text-center mt-4" {(metadata.title.clone())}
            div class="space-y-1 text-center mt-4 text-subtle text-lg" {
                p {(metadata.date.clone())}
                p {(metadata.location.clone())}
            }
            div id="typst-injected" class="prose-xl mt-8 prose-headings:all-smallcaps prose-headings:text-center lg:prose-headings:text-start prose-headings:text-2xl" {
                (content)
            }
            div class="smallcaps text-muted w-full text-center mt-6 mb-8 text-3xl select-none" {
                "yw"
            }
        })
    }
}
