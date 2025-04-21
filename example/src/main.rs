use apogee::world;
use hypertext::{GlobalAttributes, Raw, Renderable, html_elements, maud};
use std::{io::Read, path::Path};

fn main() {
    let working_dirs = world::WorkingDirs::get_dirs().unwrap();
    let mut the_world = world::World::new(working_dirs);

    let mut doc = world::TypstDoc::new(Path::new("./routes/About.typ")).unwrap();

    the_world.realize_doc(&mut doc).unwrap();
    println!("{}", the_world.get_doc_contents(doc).unwrap());
}
