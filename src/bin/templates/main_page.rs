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
            div id="typst-injected" class="prose-xl lg:prose-2xl mt-2 prose-headings:all-smallcaps prose-headings:text-center prose-h1:text-4xl lg:prose-headings:text-start lg:prose-h1:text-[2.5rem] prose-headings:font-bold prose-headings:dark:font-normal" {
                @if let Some(title) = title {
                     h1 {
                         (title)
                     }
                }
                (content)
            }
        })
    }
}
