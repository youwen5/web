mod templates;

use apogee::templating::Template;
use apogee::world::{self, WorkingDirs, World};
use std::path::Path;

fn main() {
    let working_dirs = world::WorkingDirs::get_dirs().unwrap();
    let mut the_world = World::new(working_dirs);

    let mut doc = world::TypstDoc::new(Path::new("./routes/About.typ")).unwrap();

    the_world.realize_doc(&mut doc).unwrap();
    let doc_raw = the_world.get_doc_contents(doc).unwrap();
    let mainpage = templates::mainpage::MainPageTemplate {};
    let final_html: String = mainpage
        .populate_with_generated_content(hypertext::Raw(doc_raw))
        .into();
    std::fs::write("./dist/Index.html", &final_html).unwrap();

    let the_world = World::new(WorkingDirs::get_dirs().unwrap());
    println!("{:?}", the_world.to_routes());
}
