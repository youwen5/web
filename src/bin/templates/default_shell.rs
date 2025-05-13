use hypertext::{GlobalAttributes, Renderable, Rendered, html_elements, maud};

use super::components::Head;

pub enum PageWidth {
    Wide,
    Prose,
}

/// The default "shell" around the page. Renders navigation, footer, and miscellany into place.
pub struct DefaultShell {
    pub head: Head,
    pub width: PageWidth,
}

const LOGO: hypertext::Raw<&str> = hypertext::Raw(
    r##"
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created with Inkscape (http://www.inkscape.org/) -->
<svg
   width="45px"
   height="45px"
   class="my-auto bg-surface"
   viewBox="0 0 300 300"
   version="1.1"
   id="svg1"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:svg="http://www.w3.org/2000/svg">
  <defs
     id="defs1" />
  <g
     id="layer1">
    <rect
       style="display:inline;opacity:1;fill:#56949f;fill-opacity:0;stroke:#b4637a;stroke-width:6.26026;stroke-dasharray:none;stroke-opacity:1"
       id="rect4"
       width="293.71112"
       height="293.71283"
       x="3.1441348"
       y="3.1437902" />
  </g>
  <g
     id="layer2">
    <rect
       style="opacity:1;fill:#b4637a;fill-opacity:1;stroke:#b4637a;stroke-width:2.02726;stroke-dasharray:none;stroke-opacity:1"
       id="rect3"
       width="104.72939"
       height="100.92105"
       x="120.82121"
       y="-18.898195"
       transform="rotate(45)" />
    <rect
       style="fill:#56949f;fill-opacity:1;stroke:#56949f;stroke-width:2.02717;stroke-dasharray:none;stroke-opacity:0.0392157"
       id="rect3-5"
       width="104.72939"
       height="100.92105"
       x="194.88144"
       y="-90.162048"
       transform="rotate(45)" />
  </g>
</svg>
"##,
);

impl DefaultShell {
    pub fn render_with_children(self, children: impl Renderable) -> Rendered<String> {
        let git_version = std::env::var("LUMINITE_GIT_COMMIT").unwrap_or("unstable".to_string());
        let current_time = {
            let time_str = std::env::var("LUMINITE_LAST_MODIFIED")
                .unwrap_or("sometime".to_string())
                .parse::<i64>()
                .unwrap_or(0);
            let format_description = time::macros::format_description!(
                "[year]-[month]-[day] [hour]:[minute]:[second] utc[offset_hour sign:mandatory]"
            );
            time::UtcDateTime::from_unix_timestamp(time_str)
                .expect("couldn't parse datetime from unix timestamp")
                .to_offset(time::macros::offset!(-7))
                .format(&format_description)
                .unwrap()
        };
        let rustc_verison = compile_time::rustc_version_str!();

        let nav_items = maud! {
            li {a class="hover:bg-surface transition-colors" href="/about" {"About"}}
            li {a class="hover:bg-surface transition-colors" href="/now" {"Now"}}
            li {a class="hover:bg-surface transition-colors" href="/cv" {"CV"}}
        };

        let code = maud! {
            li {a class="hover:bg-surface transition-colors" href="/luminite" {"Project: Luminite"}}
        };

        let math = maud! {
            li {a class="hover:bg-surface transition-colors" href="/math-test" {"A test of Typst math rendering"}}
        };

        let other = maud! {
            li {a class="hover:bg-surface transition-colors" href="/faqs" {"Frequently asked questions"}}
            li {a class="hover:bg-surface transition-colors" href="/impressum" {"Impressum"}}
            li {a class="hover:bg-surface transition-colors" href="/about-this-site" {"About this site"}}
        };

        let page_width = match self.width {
            PageWidth::Wide => "",
            PageWidth::Prose => " lg:max-w-2xl",
        };

        maud! {
            !DOCTYPE
            html lang="en" {
                (self.head)
                body class="antialiased mt-4 lg:mt-20 leading-relaxed mx-auto max-w-[1200px]" {
                    div class="flex gap-8 px-4 lg:px-6" {
                        aside class="hidden md:block w-64 flex-none" {
                            a href="/" class="inline-flex justify-between gap-4 hover:bg-subtle/50 transition-colors mt-3" {
                                (LOGO)
                                span class="italic text-[2.5em] select-none -translate-y-2" {"youwen wu"}
                            }
                            nav class="space-y-6 mt-4" {
                                ul class="space-y-2 text-love text-2xl " {
                                    (nav_items)
                                }
                                div class="space-y-2" {
                                    p class="all-smallcaps text-lg" {"Hacking"}
                                    ul class="space-y-2 text-subtle text-base" {
                                        (code)
                                    }
                                }
                                div class="space-y-2" {
                                    p class="all-smallcaps text-lg" {"Math"}
                                    ul class="space-y-2 text-subtle text-base" {
                                        (math)
                                    }
                                }
                                div class="space-y-2" {
                                    p class="all-smallcaps text-lg" {"Other"}
                                    ul class="space-y-2 text-subtle text-base" {
                                        (other)
                                    }
                                }
                            }
                            div class="mt-6" {
                                a href="/buttons" class="hover:brightness-75" {
                                    img class="w-20" src="/static/logo/button.png" alt="my button";
                                }
                            }
                        }
                        div class="flex-1 md:mt-2" {
                            header class="md:hidden border-b border-dashed border-muted mb-8 pb-8 w-full" {
                                div class="w-full flex justify-center" {
                                    a href="/" class="inline-flex justify-between gap-4 hover:bg-subtle/50 transition-colors mt-8 mx-auto" {
                                        (LOGO)
                                        span class="italic text-[3em] text-center select-none -translate-y-2 mx-auto" {"youwen wu"}
                                    }
                                }
                                details class="w-full mt-4" {
                                    summary class="text-center smallcaps text-xl cursor-pointer" {
                                        "menu"
                                    }
                                    nav class="space-y-8 text-2xl mt-3" {
                                        ul class="space-y-3 text-2xl text-love" {
                                            (nav_items)
                                        }
                                        div class="space-y-4" {
                                            div class="space-y-2" {
                                                p class="all-smallcaps text-lg" {"Hacking"}
                                                ul class="space-y-2 text-subtle text-lg" {
                                                    (code)
                                                }
                                            }
                                            div class="space-y-2" {
                                                p class="all-smallcaps text-lg" {"Math"}
                                                ul class="space-y-2 text-subtle text-lg" {
                                                    (math)
                                                }
                                            }
                                            div class="space-y-1" {
                                                p class="all-smallcaps text-lg" {"Other"}
                                                ul class="space-y-2 text-subtle text-lg" {
                                                    (other)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            main class=("main-content".to_owned() + page_width) {
                                (children)
                                footer class="border-t mt-8 border-solid border-muted mb-4 flex justify-between items-center gap-4 text-sm text-muted py-1" {
                                    p class="all-smallcaps" {"© 2025 Youwen Wu. Generated by "
                                        a
                                            class="text-link"
                                            href="https://github.com/youwen5/web" 
                                            {"luminite"}
                                        " from "
                                        a
                                            class="text-link"
                                            href=("https://github.com/youwen5/web/commit/".to_owned() + &git_version) 
                                        {(git_version[..8].to_string())}
                                        " using rustc " {(rustc_verison)} " at " {(current_time)} ". Most content cc-by-sa-4.0. This page uses " a href="/privacy" class="text-link" {"analytics."}
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .render()
    }
}
