use std::path::Path;

fn main() {
    println!("hello world");
    let input = Path::new("./tests/test.typ");
    let output = Path::new("./out.html");
    apogee::compile_document(input, output);
}
