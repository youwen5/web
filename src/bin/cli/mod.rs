use hypertext::Raw;
use luminite::{
    site::Site,
    templating::Template,
    world::{WorkingDirs, World},
};

use crate::templates;

use clap::{Args, Parser, Subcommand};

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
    Build(BuildArgs),
}

#[derive(Args)]
struct BuildArgs {
    #[arg(short, long)]
    /// Minify outputted HTML.
    minify: bool,
}

pub fn run() {
    let cli = Cli::parse();

    match &cli.command {
        Commands::Build(args) => {
            let main_page = templates::MainPage {};
            let prose = templates::Prose {};

            let the_world = World::new(WorkingDirs::get_dirs().unwrap());
            let mut site = Site::new(the_world.get_routes(), move |slug, content, metadata| {
                let raw_content = Raw(content);
                let rendered = match slug.as_str() {
                    "/" => main_page.render_page_with_content(raw_content, metadata),
                    "/math-test" => prose.render_page_with_content(raw_content, metadata),
                    "/luminite" => prose.render_page_with_content(raw_content, metadata),
                    "/hypermedia-and-the-insanity-of-the-web" => {
                        prose.render_page_with_content(raw_content, metadata)
                    }
                    _ => main_page.render_page_with_content(raw_content, metadata),
                };
                rendered
            });
            the_world.get_metadata(&mut site).unwrap();
            the_world.realize_site(site, args.minify).unwrap();
        }
    }
}
