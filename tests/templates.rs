use apogee::templating::Template;
use hypertext::{Renderable, Rendered, html_elements, maud};

struct TestTemplate {}
impl Template for TestTemplate {
    fn populate_with_generated_content(&self, content: hypertext::Raw<String>) -> Rendered<String> {
        maud! {
            div {
                h1 {"here's some content"}
                (content)
            }
        }
        .render()
    }
}

#[test]
fn it_templates_successfully() {
    let template = TestTemplate {};
    let injection = hypertext::Raw(String::from("<p>test content!</p>"));
    assert_eq!(
        template.populate_with_generated_content(injection),
        maud! {
            div {
                h1 {"here's some content"}
                p {
                    "test content!"
                }
            }
        }
        .render()
    );
}
