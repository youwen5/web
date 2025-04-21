use hypertext::{GlobalAttributes, Raw, Renderable, html_elements, maud};
use std::{io::Read, path::Path};

fn truncate_lines(content: &str, n_start: usize, n_end: usize) -> String {
    let lines: Vec<&str> = content.lines().collect();

    let total_lines = lines.len();

    if total_lines <= n_start + n_end {
        return String::new();
    }

    let start_index = n_start;
    let end_index = total_lines - n_end;

    let relevant_lines = &lines[start_index..end_index];

    relevant_lines.join("\n")
}

fn main() {
    apogee::world::build_html_artifacts().unwrap();

    let mut file = std::fs::File::open("./.apogee/typst-html/About.html").unwrap();
    let mut contents = String::new();
    file.read_to_string(&mut contents).unwrap();
    let truncated_source = truncate_lines(&contents, 7, 2);

    let raw = hypertext::Raw(truncated_source);

    println!(
        "{}",
        maud! {
            div #main id="typst-rendered" {
                (raw)
            }
        }
        .render()
        .as_str()
    );
}
