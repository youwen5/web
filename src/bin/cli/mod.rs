use apogee::{
    site::Site,
    templating::Template,
    world::{WorkingDirs, World},
};
use hypertext::Raw;

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
            let mainpage = templates::MainPage {};
            let aboutpage = templates::AboutPage {};
            let blog = templates::Blog {};

            let the_world = World::new(WorkingDirs::get_dirs().unwrap());
            let site = Site::new(the_world.get_routes(), move |slug, content| {
                let raw_content = Raw(content);
                let rendered = match slug.as_str() {
                    "/" => mainpage.render_page_with_content(raw_content),
                    "/about" => aboutpage.render_page_with_content(raw_content),
                    "/blog" => blog.render_page_with_content(raw_content),
                    _ => mainpage.render_page_with_content(raw_content),
                };
                rendered
            });
            the_world.build_routes(&site).unwrap();
        }
    }
}
