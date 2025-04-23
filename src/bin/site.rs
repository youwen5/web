mod cli;
mod templates;

fn main() {
    tracing_subscriber::fmt::init();
    cli::run();
}
