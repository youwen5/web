use apogee::templating::Template;
use hypertext::{html_elements, maud, Renderable, Rendered};

struct TestTemplate {}
impl Template for TestTemplate {
    fn render_page_with_content(&self, content: hypertext::Raw<String>) -> Rendered<String> {
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
        template.render_page_with_content(injection),
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
