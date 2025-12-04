/// A template specifically for prose, that formats things fancily, with some nice front matter.
use epilogue::{templating::Template, world::Metadata};
use hypertext::prelude::*;
use time::format_description;

use super::{
    components::{Giscus, Head},
    default_shell::DefaultShell,
};

pub struct Prose;

impl Template for Prose {
    fn render_page_with_content(
        &self,
        content: hypertext::Raw<String>,
        metadata: Metadata,
    ) -> Rendered<String> {
        let head = Head::new(&metadata);
        let date_format = format_description::parse("[day] [month repr:long] [year]").unwrap();
        DefaultShell {
            head,
            width: super::default_shell::PageWidth::Prose,
        }
        .render_with_children(maud! {
            @if let Some(title) = &metadata.title { h1 class="all-smallcaps md:text-3xl text-2xl text-center mt-4" {(title)} }
            div class="space-y-1 text-center mt-4" {
                @if let Some(date) = &metadata.date { p class="text-subtle text-md md:text-lg" {(date.format(&date_format).unwrap())} }
                @if let Some(location) = &metadata.location { p class="text-subtle text-md md:text-lg" {(location)} }
                @if let Some(special_author) = &metadata.special_author { p class="text-lg md:text-xl mt-5" {span class="italic" {"by " } (special_author)} }
            }
            div id="typst-injected" class="prose-lg lg:prose-xl mt-8 prose-headings:all-smallcaps prose-headings:text-love prose-h1:text-foreground prose-list-snazzy prose-table-snazzy scroll-smooth" {
                @if let Some(subtitle) = &metadata.subtitle {
                    p class="text-subtle italic" { (subtitle) }
                }
                (content)
            }
            div class="smallcaps text-muted w-full text-center mt-6 mb-8 text-3xl" {
                a href="/" class="hover:text-love" { "yw" }
            }
            @if metadata.enable_comments {(Giscus)}
        })
    }
}
