---
title: "Parallelizing this website for free"
published: 2025-05-13
---

// date: datetime(day: 13, year: 2025, month: 5),
// location: "Santa Barbara, California",
// meta-description: "I implemented parallel builds for my static site generator in 10 minutes and 1 line of code",
// enable-comments: true,

#import "@preview/html-shim:0.1.0": *
#import "@preview/cmarker:0.1.5"

#show: html-shim

There are around 20-30 pages on this website now and builds have been getting
somewhat slow (in the realm of ~4 seconds total). Since I haven't
implemented any sort of hot reload, I need to rebuild the whole site to view
any changes, and it's actually a bit cumbersome to do development
now. Using `rayon`, a data parallelism library, I parallelized the entire query
and build step and achieved a #(sym.times)6 speedup for basically zero effort.


#btw[
  This site is generated entirely by my custom static site generator
  written in Rust, and the pages are created using Typst.

  Typst is a typesetting system like LaTeX, and the Typst CLI is a program that
  compiles the Typst markup language into #smallcaps[pdf] or #smallcaps[html]
  documents.
]

Here's how the build process works at a high level:

1. Crawl the routes directory to build up an internal tree representation of
  the website, where the leaves represent webpages. Each leaf is a struct that
  holds information about the Typst document used to build it.
2. Traverse the tree and populate each leaf with metadata about the document it
  represents, by invoking `typst query` on its source file.
3. Do whatever intermediate data transformations and processing you need on the
  tree.
4. The actual build step---traverse the tree and invoking `typst build` on
  everything that needs to be built, then insert the output into an
  #smallcaps[html] template (which contains the `<head>` metadata, navbar, and
  all the other common website bits) to create the final webpage.

In the code, the tree is represented by series of nested `HashMap`s, where
the leaves represent a webpage. Tree traversal is implemented depth-first
with a combination of recursion and iteration. We call `.iter()` on the
`HashMap`, then map over all the nodes in a level. If we see a leaf
(representing a page to be built), we call `typst build` to turn it into a
raw #smallcaps[html] artifact, and then embed the content into one of our
templates . If we see a nested subtree instead, then we recursively traverse
it.

This immediately presented an obvious place to find a lot of performance gains.
It should be perfectly safe to parallelize querying metadata and building the
#smallcaps[html] artifacts, which are by far the most expensive operations.

= Parallelism for free

Writing concurrent code is a notoriously difficult task (to get right) usually,
and often the increased complexity is not worth the speed gains. But Rustaceans
reading this may know of a library called
#link("https://github.com/rayon-rs/rayon")[rayon], that can automatically
parallelize anything using `foo.iter()` by changing it into `foo.par_iter()`.
Usually it is very easy to add, so I decided to try it out.

First I needed a small refactor to separate out the build step into two phases.
In the original design, in order to build a given page, we call `typst build`
on its source and then generate the final result embedded in our
#smallcaps[html] template in one step. What we're going to do
instead is first concurrently call `typst build` on every page and build every
artifact first, followed by a second pass to generate all the final pages using
our templates.

The reason for splitting these operations up into two passes is that calling
Typst to build our initial artifacts is by far the most time consuming and
stands to benefit the most from concurrency. Actually generating the final
pages is already extremely fast, so we'll keep it serial for now.
Not to mention, it's also prone to race conditions because it
involves creating lots of nested directories and files.

A final consideration---although `rayon` handles data races very well thanks to
"fearless concurrency," it can't guarantee safety from race conditions in
real world IO. In particular, I realized that if I had two Typst files with the
same filename but representing different routes, the file would get overwritten
and things would get real wacky. (concrete example: both `/+index.typ` and
`/cv/+index.typ` would get compiled to `+index.html`, so one of them would end
up overwriting the other).

This was easily fixed by hashing the canonical path of the Typst source file
and appending it to the filename, guaranteeing that every distinct page gets a
unique filename.

```
+index-10358123698156044784.html
+index-5389558411361854159.html
```

Now we should be safe from race issues! With these slight architectural changes,
we should get the promised parallelism for free.

= So it's that easy?

Well, I also had to refactor the iterator so it used the functional patterns
`rayon` expects rather than a simple `for` loop. But yeah, after it was working
synchronously, I just needed to swap out one line of code.

Here's the refactored code of the original, slow function that does
the tree traversal and builds the artifacts:

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

We're going to make a one liner change to make it concurrent:

```rust
route_tree
    .iter_mut()
// use the parallel iterator from `rayon`
route_tree
    .par_iter_mut()
```

And we're done! In theory, our tree traversal is now going to run concurrently
thanks to `rayon`.

#btw[
  We do something very similar to parallelize the query step as well.
]

= But was it faster?

Did it work? It's Rust, so of course it worked first try!

Seriously, it really just worked. With our one-liner change, `rayon` now
automatically spins up a thread pool and spawns many concurrent `typst`
processes to perform the build.

== Benchmarks

Here's benchmark data using
#link("https://github.com/sharkdp/hyperfine")[hyperfine] on the actual site
(executed on Apple Silicon, M1 Pro, running NixOS w/ Linux 6.13.5-asahi):

1. Before (average total time elapsed, ~4.6 seconds)
  #cmarker.render(
    ```
    | Command | Mean [s] | Min [s] | Max [s] |
    |:---|---:|---:|---:|
    | `site build --minify` | 4.583 ± 0.102 | 4.454 | 4.738 |
    ```,
  )

2. After (average total time elapsed, ~0.9 seconds)
  #cmarker.render(
    ```
    | Command | Mean [ms] | Min [ms] | Max [ms] |
    |:---|---:|---:|---:|
    | `site build --minify` | 908.6 ± 26.0 | 874.9 | 943.2 |
    ```,
  )

For a more pronounced trial, I've generated 500 synthetic pages (long-form blog
posts) and then benchmarked it again.
1. Before, building 500 synthetic pages (average total time elapsed, ~65 seconds)
  #cmarker.render(
    ```
    | Command | Mean [ms] | Min [s] | Max [s] |
    |:---|---:|---:|---:|
    | `site build --minify` | 65.32 ±  1.320 | 45.24 | 71.393 |
    ```,
  )

2. After, building 500 synthetic pages (average total time elapsed, ~10 seconds)
  #cmarker.render(
    ```
    | Command | Mean [s] | Min [s] | Max [s] |
    |:---|---:|---:|---:|
    | `site build --minify` | 10.235 ± 0.051 | 10.156 | 10.316 |
    ```,
  )

= Conclusion

There is one concern that I have with my implementation. Because the tree
traversal is recursive, it makes a new call to `rayon` on every single nested
subdirectory. I'm not exactly sure how `rayon` handles this under
the hood but my suspicion is that it will spin up a new thread pool for every
single recursive invocation of `par_iter()`, which could potentially be very
slow. Right now the site only contains 3--4 nested subdirectories so
I'm not affected yet.

The best way to fix this is to probably to transform the tree into a flat
vector of pointers to each node, and then call `.par_iter()` once to operate on
every page in parallel from one thread pool.

That's a problem for later. I'm quite pleased with how
easily `rayon` was able to let me write multithreaded code without ever
thinking about synchronization, locks, mutexes, and other junk. Once again,
Rustacean technology was more powerful than I could've imagined in
my wildest dreams.
