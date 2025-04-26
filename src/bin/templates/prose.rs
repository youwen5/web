use hypertext::{html_elements, maud, GlobalAttributes, Rendered};
use luminite::templating::Template;

use super::{components::Head, default_shell::DefaultShell};

pub struct Prose;

impl Template for Prose {
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
            div id="typst-injected" class="prose-xl mt-2 prose-headings:all-smallcaps" {
                (content)
            }
        })
    }
}
