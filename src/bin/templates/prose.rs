use hypertext::{GlobalAttributes, Rendered, html_elements, maud};
use luminite::{templating::Template, world::Metadata};

use super::{components::Head, default_shell::DefaultShell};

pub struct Prose;

impl Template for Prose {
    fn render_page_with_content(
        &self,
        content: hypertext::Raw<String>,
        metadata: Metadata,
    ) -> Rendered<String> {
        let head = Head::new(&metadata);
        DefaultShell {
            head,
            width: super::default_shell::PageWidth::Prose,
        }
        .render_with_children(maud! {
            @if metadata.title.is_some() { h1 class="all-smallcaps md:text-3xl text-2xl text-center mt-4" {(metadata.title.unwrap())} }
            div class="space-y-1 text-center mt-4" {
                @if metadata.date.is_some() { p class="text-subtle text-md md:text-lg" {(metadata.date.unwrap())} }
                @if metadata.location.is_some() { p class="text-subtle text-md md:text-lg" {(metadata.location.unwrap())} }
                @if metadata.special_author.is_some() { p class="text-lg md:text-xl mt-5" {span class="italic" {"by " } (metadata.special_author.unwrap())} }
            }
            div id="typst-injected" class="prose-xl mt-8 prose-headings:all-smallcaps prose-headings:text-xl" {
                (content)
            }
            div class="smallcaps text-muted w-full text-center mt-6 mb-8 text-3xl select-none" {
                "yw"
            }
        })
    }
}
