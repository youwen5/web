use hypertext::{html_elements, maud, GlobalAttributes, Renderable, Rendered};
pub struct Blog {}

impl luminite::templating::Template for Blog {
    fn render_page_with_content(&self, content: hypertext::Raw<String>) -> Rendered<String> {
        maud! {
            !DOCTYPE
            html lang="en" {
                head {
                    meta name="viewport" content="width=device-width, initial-scale=1.0";
                    meta charset="utf-8";

                    // title { "vidhan.io" @if let Some(title) = &self.title { " / " (title) } }
                    // meta name="description" content=(DESCRIPTION);
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

                    // link rel="stylesheet" href=(cached!("/styles.css"));
                }
                body {
                    h1.important {
                        "Blog"
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
