/// Reusable components that can be placed around the site. Footers, navbars, etc.
use hypertext::{GlobalAttributes, Renderable, html_elements, maud};
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
            Some(title) => format!("{title} | Youwen Wu"),
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

                link
                    rel="stylesheet" 
                    media="screen"
                    href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/tokyo-night-light.min.css";

                link
                    rel="stylesheet" 
                    media="screen and (prefers-color-scheme: dark)"
                    href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/tokyo-night-dark.min.css";
                script async src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js" id="hljs-script" {}
                script {

                    r#"
                      document.getElementById('hljs-script').onload = function() {
                          hljs.highlightAll();
                      };
                    "#
                }
            }
        }
        .render_to(output);
    }
}

pub struct Discus;
impl Renderable for Discus {
    fn render_to(self, output: &mut String) {
        maud! {
            script src="https://giscus.app/client.js"
                data-repo="youwen5/web"
                data-repo-id="R_kgDOOc2JBQ"
                data-category="Announcements"
                data-category-id="DIC_kwDOOc2JBc4Cp8xj"
                data-mapping="pathname"
                data-strict="1"
                data-reactions-enabled="1"
                data-emit-metadata="0"
                data-input-position="top"
                data-theme="preferred_color_scheme"
                data-lang="en"
                data-loading="lazy"
                crossorigin="anonymous"
                async {}
        }
        .render_to(output);
    }
}
