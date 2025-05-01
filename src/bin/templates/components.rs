/// Reusable components that can be placed around the site. Footers, navbars, etc.
use hypertext::{Renderable, html_elements, maud};
use luminite::world::Metadata;

/// A site-wide usable head tag.
pub struct Head {
    pub page_title: Option<String>,
    pub description: Option<String>,
    pub image: Option<String>,
    pub author: Option<String>,
}

impl Head {
    pub fn new(meta: &Metadata) -> Head {
        Head {
            page_title: meta.title.to_owned(),
            author: meta.special_author.to_owned(),
            description: match &meta.meta_description {
                Some(desc) => Some(desc.to_owned()),
                None => meta.subtitle.to_owned(),
            },
            image: None,
        }
    }
}

impl Renderable for Head {
    fn render_to(self, output: &mut String) {
        let description = &self.description;
        let image = &self.image;
        let page_title = match self.page_title {
            Some(title) => format!("{} | Youwen Wu", title),
            None => "Youwen Wu".to_string(),
        };

        maud! {
            head {
                meta name="viewport" content="width=device-width, initial-scale=1.0";
                meta charset="utf-8";

                title { (&page_title) }
                meta name="og:title" content=(&page_title);
                meta name="og:site_name" content="Youwen's website";

                @if let Some(description) = description {
                    meta name="description" content=(description);
                } @else {
                    meta name="description" content="A quiet corner of the internet.";
                }

                @if let Some(description) = description {
                    meta name="og:description" content=(description);
                    meta name="twitter:description" content=(description);
                }

                @match self.author {
                    Some(author) =>  meta name="author" content=(author);
                    None =>  meta name="author" content="Youwen Wu";
                }
                // meta name="og:url" content=(url);
                meta name="og:type" content="website";
                @if let Some(image) = image { meta name="og:image" content=(image); }

                // meta name="twitter:card" content="summary_large_image";
                meta name="twitter:site" content="@youwen5";
                meta name="twitter:creator" content="@youwen5";
                meta name="twitter:title" content=(&page_title);
                // meta name="twitter:image" content=(&*image_path);
                meta name="robots" content="index, follow";

                link rel="stylesheet" href="/bundle.css";

                script data-collect-dnt="true" async src="https://scripts.simpleanalyticscdn.com/latest.js" {}
            }
        }
        .render_to(output);
    }
}
