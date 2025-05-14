#import "@luminite/html-shim:0.1.0": *

#show: html-shim.with(
  date: datetime(day: 12, year: 2025, month: 5),
  title: "Parallelizing this website for free",
  location: "Santa Barbara, California",
  meta-description: "I implemented parallel builds for my static site generator in 10 minutes and 10 lines of code",
  enable-comments: true,
)

There are around 20-30 pages on this website now and builds have been getting
somewhat slow (in the realm of ~4 seconds total). Since I haven't implemented
any sort of hot reload, I need to rebuild the whole site to view any changes,
and it's actually a bit cumbersome to do development now. Using `rayon`, a data
parallelism library, I multithreaded the entire query and build step and achieved
#(sym.times)2 speedup for basically zero effort.


#btw[
  This site is generated entirely by my custom static site generator
  written in Rust, and the pages are created using Typst.

  Typst is a typesetting system like LaTeX, and the Typst CLI is a program that
  compiles the Typst markup language into #smallcaps[pdf] or #smallcaps[html]
  documents.
]

Here's how the build process works at a high level:

1. Crawl the routes directory to build up an internal tree representation of the website.
2. Recursively walk around every Typst file in the tree and pull metadata out, by invoking `typst query` on every document.
3. Do whatever intermediate data transformations, processing, etc you need.
4. The actual build step: using the tree, execute a site build to realize it into the world. This is done by recursively walking the tree and invoking `typst build` on everything that needs to be built.

In the code, the tree is represented by a `HashMap`, and building the site is
implemented via a recursive tree traversal. We call `.iter()` on the `HashMap`,
then map over the iterator. If we see a leaf (representing a page), we call
`typst build`, and then embed the output into #smallcaps[html]. If we see a
nested subtree, then we recurse on it.

This immediately presented an obvious place to find a lot of performance gains:
we should be able to walk down each subtree in parallel. Querying metadata and
building an individual document has nothing to do with any other document, so
it should be perfectly safe to parallelize this.

= Parallelism for free

Writing parallel code is a notoriously difficult task (to get right) usually,
and often the increased complexity is not worth the speed gains. But Rustaceans
reading this may know of a library called
#link("https://github.com/rayon-rs/rayon")[rayon], that can automatically
parallelize `foo.iter()` by changing it into `foo.par_iter()`. Usually it is
very easy to add, so I decided to try it out.

First I needed to separate out the build step into two phases. Instead of
compiling the document and embedding it into a template in one step, we first
build every document in an intermediate directory. This is by far the slowest
step, because we invoke the Typst compiler on every single file, so this is
what we are going to parallelize.

The second step after we have all the built artifacts is to read all the built
files, embed it in the templates and create the final files. This part is
already really fast and requires creating nested directories, so we don't need
to parallelize this for now.

Here's the original code of the synchronous function that does the tree
traversal and builds the artifacts:

```rust
fn build_artifacts(
    &self,
    route_tree: &mut RouteTree,
    html_artifacts_path: &Path,
) -> Result<(), WorldError> {
    route_tree
        .iter_mut()
        .try_for_each(|(filename, node)| match node {
            RouteNode::Page(typst_doc) => {
                event!(Level::INFO, "Building artifact for {}", filename);

                self.build_doc(typst_doc, html_artifacts_path)?;

                event!(
                    Level::DEBUG,
                    "Built an HTML artifact from {filename}, at path {:?}",
                    typst_doc.source_path.as_os_str(),
                );

                Ok(())
            }
            RouteNode::Nested(hash_map) => self.build_artifacts(hash_map, html_artifacts_path),
            RouteNode::Redirect(_) => Ok(()),
        })
}
```

We're going to make a one liner change:

```rust
route_tree
    .iter_mut()
// use the parallel iterator from `rayon-rs`
route_tree
    .par_iter_mut()
```

And we're done! In theory, our tree traversal is now going to run in parallel
thanks to `rayon`.

#btw[
  We do something very similar to parallelize the query step as well.
]

= But was it faster?

Did it work? It's Rust, so of course it worked first try! Testing it out, I
immediately noticed a massive speedup.

= Benchmarks

Here's benchmark data from #link("https://github.com/sharkdp/hyperfine")[hyperfine] on the actual site.

1. Before (average total time elapsed, ~3.6 seconds)
  ```sh
  Benchmark 1: site build --minify
    Time (mean ± σ):      3.628 s ±  0.079 s
    Range (min … max):    3.544 s …  3.773 s    10 runs
  ```

2. After (average total time elapsed, ~0.8 seconds)
  ```sh
  Benchmark 1: site build --minify
    Time (mean ± σ):     800.9 ms ±  48.8 ms
    Range (min … max):   743.6 ms … 889.3 ms    10 runs
  ```

For a more impactful trial, I've generated 500 synthetic pages (long-form blog
posts) and then benchmarked it again.

1. Before (average total time elapsed, ~65 seconds)
  ```sh
  Benchmark 1: site build --minify
    Time (mean ± σ):      65.32 s ±  1.320 s
    Range (min … max):    45.24 s …  71.393 s    10 runs
  ```

2. After (average total time elapsed, ~10 seconds)
  ```sh
  Benchmark 1: site build --minify
    Time (mean ± σ):     10.235 s ±  0.051 s
    Range (min … max):   10.156 s … 10.316 s    10 runs
  ```

Much bigger difference with more files.

= Conclusion

Building sequentially didn't scale well, and likely would've become painfully
slow as my pages increased. As I suspected, the speed gains from
parallelization become exponentially more pronounced and impactful as the site
grows in size.
