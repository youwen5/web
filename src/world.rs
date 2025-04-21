/// Procedures for interacting with the World.
use std::{path, process::Command};

/// Given a path to an entrypoint `main.typ` and an output location, use the Typst CLI to compile
/// an HTML artifact. Requires `typst` to be in `$PATH`. The directory of the output must exist or
/// an error will occur.
pub fn compile_document(input: &path::Path, output: &path::Path) -> Result<(), std::io::Error> {
    let resolved_document = input.canonicalize()?;
    if let Some(dir) = output.parent() {
        if !dir.exists() {
            return Err(std::io::Error::new(
                std::io::ErrorKind::Other,
                "Directory doesn't exist.",
            ));
        }
    }

    let mut typst = Command::new("typst")
        .arg("compile")
        .args(["--features", "html"])
        .args(["--format", "html"])
        .args([
            "--root",
            resolved_document
                .parent()
                .unwrap()
                .to_str()
                .expect("Could not cast document directory to a string."),
        ])
        .arg(
            resolved_document
                .to_str()
                .expect("Failed to cast document to a string."),
        )
        .arg(
            output
                .to_str()
                .expect("Failed to cast output path to a string."),
        )
        .spawn()?;

    typst.wait().expect("failed to wait on Typst");
    Ok(())
}

pub struct WorkingDirs {
    dist: std::path::PathBuf,
    factory: std::path::PathBuf,
}

impl WorkingDirs {
    /// Set up the working directories, `dist` for built artifacts and `.apogee` for intermediate
    /// artifacts, as well as intermediate directories.
    fn setup_working_dirs() -> Result<WorkingDirs, std::io::Error> {
        let dist_path = std::path::Path::new("./dist");
        let factory_path = std::path::Path::new("./.apogee");
        if std::fs::exists(dist_path)? {
            std::fs::remove_dir_all(dist_path)?;
        }
        if std::fs::exists(factory_path)? {
            std::fs::remove_dir_all(factory_path)?;
        }
        std::fs::create_dir_all("./dist")?;
        std::fs::create_dir_all("./.apogee")?;
        Ok(WorkingDirs {
            dist: dist_path.to_path_buf(),
            factory: factory_path.to_path_buf(),
        })
    }

    pub fn working_dirs_exist() -> Result<bool, std::io::Error> {
        let dist_path = std::path::Path::new("./dist");
        let factory_path = std::path::Path::new("./.apogee");

        Ok(std::fs::exists(dist_path)?
            && std::fs::exists(factory_path)?
            && dist_path.is_dir()
            && factory_path.is_dir())
    }

    /// Guarantees that the working directories exist and returns their `PathBuf`s.
    pub fn get_dirs() -> Result<WorkingDirs, std::io::Error> {
        if !WorkingDirs::working_dirs_exist()? {
            return WorkingDirs::setup_working_dirs();
        }

        let dist_path = std::path::Path::new("./dist");
        let factory_path = std::path::Path::new("./.apogee");

        Ok(WorkingDirs {
            dist: dist_path.to_path_buf(),
            factory: factory_path.to_path_buf(),
        })
    }
}

/// Build all Typst documents into HTML artifacts for further processing.
pub fn build_html_artifacts() -> Result<(), std::io::Error> {
    let dirs = WorkingDirs::get_dirs()?;
    let mut html_artifacts_path = dirs.factory.clone();
    html_artifacts_path.push(std::path::Path::new("./typst-html"));

    if html_artifacts_path.is_dir() || std::fs::exists(&html_artifacts_path)? {
        std::fs::remove_dir_all(&html_artifacts_path)?;
    }

    std::fs::create_dir(&html_artifacts_path)?;

    let temp_file_names = [std::path::Path::new("./example/About.typ")];

    for file in temp_file_names.iter() {
        let output_path = html_artifacts_path.join(std::path::PathBuf::from(format!(
            "./{}.html",
            file.file_stem().unwrap().to_str().unwrap()
        )));
        compile_document(file, &output_path).expect("Could not compile document.");
    }

    Ok(())
}
