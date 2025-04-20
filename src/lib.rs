use std::{path, process::Command};

pub fn compile_document(input: &path::Path, output: &path::Path) {
    let resolved_document = input
        .canonicalize()
        .expect("could not resolve input document");
    if let Some(dir) = output.parent() {
        if !dir.exists() {
            panic!("output directory does not exist")
        }
    }

    let mut typst = Command::new("typst")
        .arg("compile")
        .args(["--features", "html"])
        .args(["--format", "html"])
        .args([
            "--root",
            resolved_document.parent().unwrap().to_str().unwrap(),
        ])
        .arg(resolved_document.to_str().unwrap())
        .arg(output.to_str().unwrap())
        .spawn()
        .expect("Could not run Typst CLI");

    typst.wait().expect("failed to wait on Typst");
}
