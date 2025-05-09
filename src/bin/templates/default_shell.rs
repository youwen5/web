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
            li {a class="hover:bg-overlay transition-colors" href="/projects" {"Projects"}}
            li {a class="hover:bg-overlay transition-colors" href="/now" {"Now"}}
            li {a class="hover:bg-overlay transition-colors" href="/impressum" {"Impressum"}}
        };

        let code = maud! {
            li {a class="hover:bg-overlay transition-colors" href="/luminite" {"Project: Luminite"}}
        };

        let math = maud! {
            li {a class="hover:bg-overlay transition-colors" href="/math-test" {"Tidbit: A test of Typst math rendering"}}
        };

        let other = maud! {
            li {a class="hover:bg-overlay transition-colors" href="/faqs" {"Frequently asked questions"}}
            li {a class="hover:bg-overlay transition-colors" href="/colophon" {"Colophon"}}
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
                            a class="italic text-[3em] hover:bg-subtle/50 transition-colors select-none" href="/" {"youwen wu"}
                            nav class="space-y-6 mt-4" {
                                ul class="space-y-2 text-love text-2xl " {
                                    (nav_items)
                                }
                                div class="space-y-2" {
                                    p class="all-smallcaps text-xl" {"Hacking"}
                                    ul class="italic space-y-2 text-subtle text-lg" {
                                        (code)
                                    }
                                }
                                div class="space-y-2" {
                                    p class="all-smallcaps text-xl" {"Math"}
                                    ul class="italic space-y-2 text-subtle text-lg" {
                                        (math)
                                    }
                                }
                                div class="space-y-2" {
                                    p class="all-smallcaps text-xl" {"Other"}
                                    ul class="italic space-y-2 text-subtle text-lg" {
                                        (other)
                                    }
                                }
                            }
                        }
                        div class="flex-1 md:mt-2" {
                            div class="md:hidden border-b border-dashed border-muted mb-8 pb-8 w-full"  {
                                p class="text-center italic text-[3em] hover:text-subtle mt-8 select-none" {a href="/" {"youwen wu"}}
                                details class="w-full mt-4" {
                                    summary class="text-center smallcaps text-xl cursor-pointer" {
                                        "menu"
                                    }
                                    nav class="space-y-8 text-2xl mt-3" {
                                        ul class="space-y-3 text-2xl text-love" {
                                            (nav_items)
                                        }
                                        div class="space-y-3" {
                                            div class="space-y-2" {
                                                p class="all-smallcaps text-xl" {"Hacking"}
                                                ul class="italic space-y-2 text-subtle text-lg" {
                                                    (code)
                                                }
                                            }
                                            div class="space-y-2" {
                                                p class="all-smallcaps text-xl" {"Math"}
                                                ul class="italic space-y-2 text-subtle text-lg" {
                                                    (math)
                                                }
                                            }
                                            div class="space-y-1" {
                                                p class="all-smallcaps text-xl" {"Other"}
                                                ul class="italic space-y-2 text-subtle text-lg" {
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
                                            class="hover:text-love text-iris"
                                            href="https://github.com/youwen5/web" 
                                            {"luminite"}
                                        " from "
                                        a
                                            class="hover:text-love text-iris"
                                            href=("https://github.com/youwen5/web/commit/".to_owned() + &git_version) 
                                        {(git_version[..8].to_string())}
                                        " using rustc " {(rustc_verison)} " at " {(current_time)} ". Most content cc-by-sa-4.0. This page uses " a href="/privacy" class="hover:text-love text-iris" {"analytics."}
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
