#import "@preview/html-shim:0.1.0": *

#show: html-shim.with(
  date: datetime(day: 16, year: 2025, month: 5),
  title: "Do you want to write?",
  location: "Santa Barbara, California",
  meta-description: "A letter to everyone with an overengineered personal blog.",
  enable-comments: true,
)

#dropcap[
  I#smallcaps(all: true)[n principle, yes.] I’d love to write more,
  as an abstract concept. I like the _idea_ of putting thoughts to written word.
  _I want to write_.
]

So I built a #link(
  "https://old.youwen.dev/devlog/2024/first-post",
  newtab: true,
)[blog into my website] with all the bells and whistles. GitHub flavored
markdown, math rendering, callouts, chapter indicator---you name it, I got it.

So I built a #link("https://blog.youwen.dev", newtab: true)[blog using
  Haskell]. Because actually, I couldn’t write in the first one---it
was written with web technologies and that’s not hipster enough.

So I built this website, with its meticulous typography and tasteful colors and a
#link("https://practicaltypography.com/valkyrie.html", newtab: true)[\$119
  font]. Because actually, I couldn’t write in the other one---since
it used Markdown, and I preferred to write in Typst.

And now I’m finally writing. After two previous posts about the
engineering that went into website so I could write in it, I can finally
write---about wanting to write.

#dinkus

If I really wanted to write, I’d just have a Substack. Or
Medium---and if those weren’t indie enough, I’d have
done it in Markdown, on one of my old blogs. Or deployed an Astro template.

But instead I spent 3 weeks crafting a website from scratch, meticulously
adjusting the font spacing and justification and pixel-by-pixel margins so the
presentation looks perfect. I wrote my own static site generator. I implemented
parallel threaded page rendering. I did everything but _actually write_.

So do I really want to write, or just engineer a blog?

#dinkus

On one hand---what is the point of a blog generator if you aren’t
going to blog? On the other hand---who cares? Is it a waste of time to
meticulously craft the most eye-pleasing website and proceed to populate it
with a #quote(smallcaps[hello world]) post? By that metric, so is playing a
video game, or learning an academic programming language, or writing a toy OS
kernel, or a smörgåsbord of other delightful computer pastimes.

So here’s to all the blog engineers out there. Don’t be
ashamed of your #smallcaps[hello world] and #smallcaps[first post] and
#smallcaps[a test of rendering] entries. No more should you feel sheepish after
deploying a website with everything but the kitchen sink just to leave it with
two posts about setting up the blog and a #smallcaps[hello world]. Go forth. Be
free.
