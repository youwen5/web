use hypertext::{html_elements, maud, GlobalAttributes, Rendered};
use luminite::{templating::Template, world::Metadata};

use super::{components::Head, default_shell::DefaultShell};

pub struct MainPage;

impl Template for MainPage {
    fn render_page_with_content(
        &self,
        content: hypertext::Raw<String>,
        metadata: &Metadata,
    ) -> Rendered<String> {
        let title = metadata.title.clone();

        DefaultShell {
            head: Head {
                page_title: None,
                author: None,
                description: None,
                image: None,
                meta_title: None,
            },
            width: super::default_shell::PageWidth::Wide,
        }
        .render_with_children(maud! {
            div id="typst-injected" class="prose-xl lg:prose-2xl mt-2 prose-headings:all-smallcaps prose-h1:text-3xl lg:prose-h1:text-[2.5rem] prose-h1:font-normal prose-headings:text-xl" {
                @if let Some(title) = title {
                     h1 class="text-center md:text-start" {
                         (title)
                     }
                }
                (content)
            }
        })
    }
}
