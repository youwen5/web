use hypertext::{GlobalAttributes, Rendered, html_elements, maud};
use luminite::templating::Template;

use super::{components::Head, default_shell::DefaultShell};

pub struct MainPage;

impl Template for MainPage {
    fn render_page_with_content(&self, content: hypertext::Raw<String>) -> Rendered<String> {
        DefaultShell {
            head: Head {
                page_title: None,
                author: None,
                description: None,
                image: None,
                meta_title: None,
            },
        }
        .render_with_children(maud! {
            div id="typst-injected" class="prose-xl xl:prose-2xl mt-2 prose-headings:all-smallcaps prose-headings:text-center lg:prose-headings:text-start" {
                (content)
            }
        })
    }
}
