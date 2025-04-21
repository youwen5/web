use std::path::Path;
mod world;

fn main() {
    world::build_html_artifacts().unwrap();
}
