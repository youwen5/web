mod templates;

use apogee::site::Site;
use apogee::templating::Template;
use apogee::world::{WorkingDirs, World};
use hypertext::Raw;

fn main() {
    let mainpage = templates::mainpage::MainPage {};
    let aboutpage = templates::aboutpage::AboutPage {};

    let the_world = World::new(WorkingDirs::get_dirs().unwrap());
    let site = Site::new(the_world.get_routes(), move |slug, content| {
        let raw_content = Raw(content);
        let rendered = match slug.as_str() {
            "/" => mainpage.render_page_with_content(raw_content),
            "/about" => aboutpage.render_page_with_content(raw_content),
            _ => mainpage.render_page_with_content(raw_content),
        };
        rendered
    });
    the_world.build_routes(&site).unwrap();
}
