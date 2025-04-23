mod templates;

use apogee::site::Site;
use apogee::templating::Template;
use apogee::world::{self, WorkingDirs, World};
use hypertext::Raw;
use std::path::Path;
use templates::aboutpage;

fn main() {
    // let working_dirs = world::WorkingDirs::get_dirs().unwrap();
    // let mut the_world = World::new(working_dirs);

    // let mut doc = world::TypstDoc::new(Path::new("./routes/+About.typ")).unwrap();
    //
    // the_world.realize_doc(&mut doc).unwrap();
    // let doc_raw = the_world.get_doc_contents(doc).unwrap();
    let mainpage = templates::mainpage::MainPage {};
    let aboutpage = templates::aboutpage::AboutPage {};
    // let final_html: String = mainpage
    //     .populate_with_generated_content(hypertext::Raw(doc_raw))
    //     .into();
    // std::fs::write("./dist/Index.html", &final_html).unwrap();

    let the_world = World::new(WorkingDirs::get_dirs().unwrap());
    let site = Site::new(the_world.to_routes(), move |slug, content| {
        let raw_content = Raw(content);
        let rendered = match slug.as_str() {
            "/" => mainpage.render_page_with_content(raw_content),
            "/about" => aboutpage.render_page_with_content(raw_content),
            _ => mainpage.render_page_with_content(raw_content),
        };
        println!("{:?}", rendered);
        rendered
    });
    the_world.build_site(&site).unwrap();
}
