use crate::templates;
use epilogue::{
    site::Site,
    templating::Template,
    world::{WorkingDirs, World},
};
use hypertext::Raw;

use clap::{ArgAction, Args, Parser, Subcommand};

#[derive(Parser)]
#[command(version, about, long_about = None)]
#[command(propagate_version = true)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
    #[arg(short, long, action = ArgAction::Count)]
    verbose: u8,
    #[arg(short, long, conflicts_with = "verbose")]
    quiet: bool,
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

    let log_level = if cli.quiet {
        tracing::Level::ERROR
    } else {
        match cli.verbose {
            0 => tracing::Level::WARN,
            1 => tracing::Level::INFO,
            2 => tracing::Level::DEBUG,
            _ => tracing::Level::TRACE,
        }
    };

    tracing_subscriber::fmt().with_max_level(log_level).init();

    match &cli.command {
        Commands::Build(args) => {
            let wide_page = templates::WidePage;
            let prose = templates::Prose;
            let index = templates::Index;

            let the_world = World::from(match WorkingDirs::get_dirs() {
                Ok(dirs) => dirs,
                Err(err) => {
                    tracing::event!(
                        tracing::Level::ERROR,
                        "Something went wrong when I was trying to create the working directories (`dist` and `.epilogue`). If these directories already exist, you should delete them and try again. I failed with the error {}",
                        err
                    );
                    return;
                }
            });

            let routes = match the_world.get_routes() {
                Ok(routes) => routes,
                Err(err) => {
                    tracing::event!(
                        tracing::Level::ERROR,
                        "I couldn't parse the routes directory! Are you sure you've set it up correctly? Does it exist? Are you in the right directory? I failed with the error {}.",
                        err
                    );
                    return;
                }
            };

            let site = Site::new(routes, move |slug, content, metadata| {
                let raw_content = Raw(content);

                match slug.as_str() {
                    "/" => index.render_page_with_content(raw_content, metadata),
                    "/colophon" => wide_page.render_page_with_content(raw_content, metadata),
                    "/impressum" => wide_page.render_page_with_content(raw_content, metadata),
                    "/privacy" => wide_page.render_page_with_content(raw_content, metadata),
                    "/photos" => wide_page.render_page_with_content(raw_content, metadata),
                    _ => prose.render_page_with_content(raw_content, metadata),
                }
            });

            if let Err(err) = the_world.realize_site(site, args.minify) {
                match err {
                    epilogue::world::WorldError::TypstQuery => {
                        tracing::event!(
                            tracing::Level::ERROR,
                            "I tried to query your routes for metadata, but something went wrong! Are you sure you've set up the `html-shim` correctly? Otherwise, metadata won't be generated! I failed with the error {}",
                            err
                        );
                    }
                    _ => {
                        tracing::event!(
                            tracing::Level::ERROR,
                            "I was able to parse your routes and begin scaffolding your site, but something went wrong actually trying to build it! Check your configuration. I failed with the error: {}",
                            err
                        );
                    }
                }
            };
        }
    }
}
