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
        let nav_items = maud! {
            li {a class="hover:bg-overlay transition-colors" href="/projects" {"Projects"}}
            li {a class="hover:bg-overlay transition-colors" href="/essays" {"Essays"}}
            li {a class="hover:bg-overlay transition-colors" href="/impressum" {"Impressum"}}
        };

        let code = maud! {
            li {a class="hover:bg-overlay transition-colors" href="/the-web-is-insane" {"Essay: The web is insane"}}
            li {a class="hover:bg-overlay transition-colors" href="/luminite" {"Project: Luminite"}}
        };

        let math = maud! {
            li {a class="hover:bg-overlay transition-colors" href="/math-test" {"Tidbit: A test of Typst math rendering"}}
        };

        let other = maud! {
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
                body class="font-sans antialiased leading-relaxed mx-auto max-w-[1200px]" {
                    div class="flex gap-8 px-4 lg:px-6 lg:mt-20" {
                        aside class="hidden lg:block w-64 flex-none" {
                            a class="italic text-[3em] hover:bg-subtle/50 transition-colors select-none" href="/" {"youwen wu"}
                            nav class="space-y-8 mt-4" {
                                ul class="space-y-2 text-love text-2xl " {
                                    (nav_items)
                                }
                                div class="space-y-4" {
                                    p class="text-3xl" {"Code"}
                                    ul class="italic space-y-2 text-subtle text-xl" {
                                        (code)
                                    }
                                }
                                div class="space-y-4" {
                                    p class="text-3xl" {"Math"}
                                    ul class="italic space-y-2 text-subtle text-xl" {
                                        (math)
                                    }
                                }
                                div class="space-y-4" {
                                    p class="text-3xl" {"Other"}
                                    ul class="italic space-y-2 text-subtle text-xl" {
                                        (other)
                                    }
                                }
                            }
                        }
                        div class="flex-1 lg:mt-2" {
                            div class="lg:hidden border-b border-dashed border-muted mb-8 pb-8 w-full"  {
                                p class="text-center italic text-[3em] hover:text-subtle mt-8 select-none" {a href="/" {"youwen wu"}}
                                details class="w-full mt-8" {
                                    summary class="text-center smallcaps text-xl cursor-pointer" {
                                        "menu"
                                    }
                                    nav class="space-y-8 text-2xl mt-3" {
                                        ul class="space-y-3 text-2xl text-love" {
                                            (nav_items)
                                        }
                                        div class="space-y-3" {
                                            p class="text-2xl" {"Code"}
                                            ul class="italic space-y-2 text-subtle text-xl" {
                                                (code)
                                            }
                                            p class="text-2xl" {"Math"}
                                            ul class="italic space-y-2 text-subtle text-xl" {
                                                (math)
                                            }
                                            p class="text-2xl" {"Math"}
                                            ul class="italic space-y-2 text-subtle text-xl" {
                                                (other)
                                            }
                                }
                                    }
                                }
                            }
                            main class=("main-content".to_owned() + page_width) {
                                (children)
                                footer class="border-t border-solid border-muted mb-4 flex justify-between items-center gap-4 text-lg text-muted py-1 mt-10" {
                                    p class="smallcaps" {"© 2025 Youwen Wu. Proudly generated by " a class="text-rose" style="text-decoration: none !important;" href="https://github.com/youwen5/luminite" {"luminite"}"."}
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
