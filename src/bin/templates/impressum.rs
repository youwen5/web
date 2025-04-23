use hypertext::{GlobalAttributes, Renderable, Rendered, html_elements, maud};
pub struct Impressum {}

impl luminite::templating::Template for Impressum {
    fn render_page_with_content(&self, content: hypertext::Raw<String>) -> Rendered<String> {
        maud! {
            !DOCTYPE
            html lang="en" {
                head {
                    meta name="viewport" content="width=device-width, initial-scale=1.0";
                    meta charset="utf-8";

                    title { "Youwen Wu's site" }
                    meta name="description" content="A quiet corner of the internet.";
                    // meta name="theme-color" content="#00ff80";

                    // meta name="og:title" content=(meta_title);
                    // meta name="og:description" content=(DESCRIPTION);
                    // meta name="og:url" content=(url);
                    // meta name="og:type" content="website";
                    // meta name="og:image" content=(&*image_path);

                    // meta name="twitter:card" content="summary_large_image";
                    // meta name="twitter:site" content="@vidhanio";
                    // meta name="twitter:creator" content="@vidhanio";
                    // meta name="twitter:title" content=(meta_title);
                    // meta name="twitter:description" content=(DESCRIPTION);
                    // meta name="twitter:image" content=(&*image_path);

                    link rel="stylesheet" href="/style.css";
                }
                body class="main-content" {
                    div class="navbar" {
                        p style="font-weight: bold; font-size: 2em; margin-top: 10px; margin-bottom: 2px;" {"Youwen Wu"}
                        div style="padding-top: 10px;" {
                            a style="font-size: 1.2em; margin-left: 14px;" href="/" {"Home"}
                            a style="font-size: 1.2em; margin-left: 14px;" href="/impressum" {"Impressum"}
                        }
                    }
                    div id="typst-injected" {
                        (content)
                    }
                }
            }
        }
        .render()
    }
}
