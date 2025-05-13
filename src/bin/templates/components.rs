/// Reusable components that can be placed around the site. Footers, navbars, etc.
use hypertext::{GlobalAttributes, Raw, Renderable, html_elements, maud};
use luminite::world::Metadata;

/// A site-wide usable head tag.
pub struct Head {
    pub page_title: Option<String>,
    pub description: Option<String>,
    pub thumbnail: Option<String>,
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
            thumbnail: meta.thumbnail.to_owned(),
        }
    }
}

const LAZY_HLJS_CSS: hypertext::Raw<&str> = Raw(r#"
<link
    rel="preload"
    href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github.min.css"
    as="style"
    media="screen"
    onload="this.onload=null;this.rel='stylesheet'"
>
<link
    rel="preload"
    href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github-dark.min.css"
    as="style"
    media="screen and (prefers-color-scheme: dark)"
    onload="this.onload=null;this.rel='stylesheet'"
>
"#);

impl Renderable for Head {
    fn render_to(self, output: &mut String) {
        let description = match &self.description {
            Some(desc) => desc,
            None => {
                "Youwen's personal website. Also a gathering hub for supporters of homotopy coherent mathematics. Together we shall prevail against the set theorists."
            }
        };
        let image = match &self.thumbnail {
            Some(image) => image,
            None => "/static/logo/button.png",
        };
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
                meta name="og:site_name" content="Youwen's Website";

                meta name="description" content=(description);

                meta name="og:description" content=(description);
                meta name="twitter:description" content=(description);

                @match self.author {
                    Some(author) =>  meta name="author" content=(author);
                    None =>  meta name="author" content="Youwen Wu";
                }
                // meta name="og:url" content=(url);
                meta name="og:type" content="website";
                meta name="og:image" content=(image);

                // meta name="twitter:card" content="summary_large_image";
                meta name="twitter:site" content="@youwen5";
                meta name="twitter:creator" content="@youwen5";
                meta name="twitter:title" content=(&page_title);
                meta name="twitter:image" content=(image);
                meta name="robots" content="index, follow";

                link rel="stylesheet" href="/bundle.css";

                (LAZY_HLJS_CSS)

                noscript {
                    link
                        rel="stylesheet"
                        media="screen"
                        href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github-dark.min.css";
                    link
                        rel="stylesheet"
                        media="screen and (prefers-color-scheme: dark)"
                        href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github.min.css";
                }

                script async src="/index.js" {}
                script async src="/icons.js" {}
                script defer src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js" id="hljs-script" {}
                script {
                    r#"
                    document.getElementById('hljs-script').onload = function() {
                        hljs.highlightAll();
                    };
                    "#
                }
                script data-collect-dnt="true" defer src="https://scripts.simpleanalyticscdn.com/latest.js" {}

            }
        }
        .render_to(output);
    }
}

pub struct Giscus;
impl Renderable for Giscus {
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
                data-theme="https://web.youwen.dev/styles/giscus.css"
                data-lang="en"
                data-loading="lazy"
                crossorigin="anonymous"
                async {}
        }
        .render_to(output);
    }
}
