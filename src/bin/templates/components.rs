use epilogue::world::Metadata;
/// Reusable components that can be placed around the site. Footers, navbars, etc.
use hypertext::{Buffer, Raw, prelude::*};

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

const LAZY_PRISM_CSS: Raw<&str> = Raw::dangerously_create(
    r#"
<link
    rel="preload"
    href="/styles/prism-catppuccin.css"
    as="style"
    media="screen"
    onload="this.onload=null;this.rel='stylesheet'"
>
<link
    rel="preload"
    href="/styles/prism-rose-pine.css"
    as="style"
    media="screen and (prefers-color-scheme: dark)"
    onload="this.onload=null;this.rel='stylesheet'"
>
"#,
);

const INLINE_FONTS: Raw<&str> = Raw::dangerously_create(
    r##"
@font-face {
  font-family: "Source Sans 3";
  font-style: normal;
  font-display: swap;
  font-weight: 300;
  src: url("/fonts/source-sans-3-latin-300-normal.woff2") format("woff2");

}

@font-face {
  font-family: "Source Sans 3";
  font-style: normal;
  font-display: swap;
  font-weight: 400;
  src: url("/fonts/source-sans-3-latin-400-normal.woff2") format("woff2");
}

@font-face {
  font-family: "Valkyrie A";
  font-style: normal;
  font-weight: normal;
  font-stretch: normal;
  font-display: swap;
  src: url("/fonts/valkyrie_ot_a_regular.woff2") format("woff2");
}

@font-face {
  font-family: "Valkyrie A";
  font-style: italic;
  font-weight: normal;
  font-stretch: normal;
  font-display: swap;
  src: url("/fonts/valkyrie_ot_a_italic.woff2") format("woff2");
}

@font-face {
  font-family: "Valkyrie A";
  font-style: normal;
  font-weight: bold;
  font-stretch: normal;
  font-display: swap;
  src: url("/fonts/valkyrie_ot_a_bold.woff2") format("woff2");
}

@font-face {
  font-family: "Valkyrie A";
  font-style: italic;
  font-weight: bold;
  font-stretch: normal;
  font-display: swap;
  src: url("/fonts/valkyrie_ot_a_bold_italic.woff2") format("woff2");
}

@font-face {
  font-family: "Concourse Index";
  font-style: normal;
  font-weight: normal;
  font-stretch: normal;
  font-display: swap;
  src: url("/fonts/concourse_index_regular.woff2") format("woff2");
}
    "##,
);

impl Renderable for Head {
    fn render_to(&self, output: &mut Buffer) {
        let description = match &self.description {
            Some(desc) => desc,
            None => {
                "Youwen’s personal website. Also a gathering hub for supporters of homotopy coherent mathematics. Together we shall prevail against the set theorists."
            }
        };
        let image = match &self.thumbnail {
            Some(image) => image,
            None => "/static/logo/button.png",
        };
        let page_title = match &self.page_title {
            Some(title) => format!("{title} | Youwen Wu"),
            None => "Youwen Wu".to_string(),
        };

        maud! {
            head {
                meta name="viewport" content="width=device-width, initial-scale=1.0";
                meta charset="utf-8";

                title { (&page_title) }
                meta name="og:title" content=(&page_title);
                meta name="og:site_name" content="Youwen’s Website";

                meta name="description" content=(description);

                meta name="og:description" content=(description);
                meta name="twitter:description" content=(description);

                @match &self.author {
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

                // prefetch essential fonts
                link rel="preload" as="font" href="/fonts/valkyrie_ot_a_regular.woff2" crossorigin;
                link rel="preload" as="font" href="/fonts/valkyrie_ot_a_italic.woff2" crossorigin;

                // inline the rest of fonts for performance
                style { (INLINE_FONTS) }

                link rel="stylesheet" href="/bundle.css";
                (LAZY_PRISM_CSS)

                script async src="/icons.js" {}
                script async src="/index.js" {}
                script defer src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.30.0/components/prism-core.min.js" id="prism-script" {}
                script defer src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.30.0/plugins/autoloader/prism-autoloader.min.js" id="prism-autoloader" {}

                noscript {
                    link
                        rel="stylesheet"
                        media="screen"
                        href="/styles/prism-catppuccin.css";
                    link
                        rel="stylesheet"
                        media="screen and (prefers-color-scheme: dark)"
                        href="/styles/prism-rose-pine.css";
                }
                script defer src="/cdn-cgi/zaraz/i.js" {}
            }
        }
        .render_to(output);
    }
}

pub struct Giscus;
impl Renderable for Giscus {
    fn render_to(&self, output: &mut Buffer) {
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
