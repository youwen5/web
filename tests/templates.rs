use hypertext::{html_elements, maud, Renderable, Rendered};
use luminite::{templating::Template, world::Metadata};

struct TestTemplate {}
impl Template for TestTemplate {
    fn render_page_with_content(
        &self,
        content: hypertext::Raw<String>,
        _metadata: &Metadata,
    ) -> Rendered<String> {
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
        template.render_page_with_content(
            injection,
            &Metadata {
                location: None,
                special_author: None,
                date: None,
                title: None,
            }
        ),
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
