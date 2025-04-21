use std::{io::Read, path::Path};
mod world;
use hypertext::{html_elements, maud, GlobalAttributes, Raw, Renderable};

fn main() {
    // world::build_html_artifacts().unwrap();

    let mut file = std::fs::File::open("./.apogee/typst-html/About.html").unwrap();
    let mut contents = String::new();
    file.read_to_string(&mut contents).unwrap();

    let raw = hypertext::Raw(contents);

    println!(
        "{}",
        maud! {
            div #main title="Main Div" {
                h1.important {
                    (raw)
                }
            }
        }
        .render()
        .as_str()
    );
}
