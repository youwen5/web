use hypertext::{GlobalAttributes, Rendered, html_elements, maud};
use luminite::{templating::Template, world::Metadata};

use super::{components::Head, default_shell::DefaultShell};

pub struct MainPage;

impl Template for MainPage {
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
            div id="typst-injected" class="prose-lg md:prose-xl xl:prose-2xl mt-2 prose-headings:all-smallcaps prose-h1:text-3xl lg:prose-h1:text-[2.5rem] prose-h1:font-normal prose-headings:text-xl" {
                @if metadata.title.is_some() {
                     h1 class="text-center md:text-start" {
                         (metadata.title.unwrap())
                     }
                }
                (content)
            }
        })
    }
}
