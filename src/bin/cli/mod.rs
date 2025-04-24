use hypertext::Raw;
use luminite::{
    site::Site,
    templating::Template,
    world::{WorkingDirs, World},
};

use crate::templates;

use clap::{Parser, Subcommand};

#[derive(Parser)]
#[command(version, about, long_about = None)]
#[command(propagate_version = true)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Compile the website. Must be ran from the root directory of the project.
    Build,
}

pub fn run() {
    let cli = Cli::parse();

    match &cli.command {
        Commands::Build => {
            let main_page = templates::MainPage {};
            let about_page = templates::AboutPage {};
            let prose = templates::Prose {};
            let impressum = templates::Impressum {};

            let the_world = World::new(WorkingDirs::get_dirs().unwrap());
            let site = Site::new(the_world.get_routes(), move |slug, content| {
                let raw_content = Raw(content);
                let rendered = match slug.as_str() {
                    "/" => main_page.render_page_with_content(raw_content),
                    "/about" => about_page.render_page_with_content(raw_content),
                    "/math-test" => prose.render_page_with_content(raw_content),
                    "/impressum" => impressum.render_page_with_content(raw_content),
                    _ => main_page.render_page_with_content(raw_content),
                };
                rendered
            });
            the_world.realize_site(&site).unwrap();
        }
    }
}
