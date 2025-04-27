#import "./lib/html-shim.typ": *

#show: html-shim.with(
  date: datetime(
    day: 26,
    year: 2025,
    month: 4,
  ).display("[day] [month repr:long] [year]"),
  location: "Santa Barbara, California",
  title: "Hypermedia and the insanity of the web",
)

Earlier I was setting up Tailwind CSS for this site, one of the few
developments out of the hodgepodge of modern web development that doesn't suck.

All is well and good, I commit the code and push it upstream. A bit later, I'm
curious what the biggest assets are in this project so I boot up Cachix and
sort by file size. I'm expecting to see `rustc` or maybe some binary
artifacts at the top. Instead, by far the largest artifact in the cache was
`node_modules`, at a whopping `200mb`.

_*`200mb`*_? Are you kidding me? I'm not bundling any JavaScript or using
any libraries. The only thing I'm even using #smallcaps[npm] for is to do some CSS pre-processing.

But this isn't going to be yet another essay about why #smallcaps[npm]
dependencies are bad and JavaScript sucks. Everyone knows these things to be
true already. Rather, I'd like to have a brief discussion about the nature and
purpose of the web.

== you don't need that framework

As of now, this website ships absolutely no JavaScript to you. I am not sure at
what point I will have to begin shipping non-trivial site--wide JavaScript, but
for now I don't even have a `<script>` tag.

This was a conscious choice on my part. As an experiment, I decided to write
this entire website by rendering Typst (a document markup language) to
#smallcaps[html] and embedding it in #smallcaps[html] templates. At the end,
the entire site is just comprised of raw #smallcaps[html] strings that my
custom #link("http://localhost:8080/luminite")[static site generator] places
into the right paths.

And this is completely enough for a site like this. I can see no reason why I
would need any sort of web framework. Yet a few months ago I couldn't even
conceive of doing web development without one.

I make the case that like me, you don't need a #quote[framework] at all. Way back
in ancient history (2013), React was released to help Facebook keep up with the
increasingly interactive demands of their user experience. But not everyone is
building Facebook. If you're building a personal site, or a site for your club,
or any sort of content-driven app, you almost certainly don't really need the
fine-grained reactivity of React and friends.

By the way, I am not interested in the particular merits of any given framework
here. We have #link("https://svelte.dev/")[sane] and
#link("https://elm-lang.org/")[genuinely powerful] ways to do web app
development. I argue that you probably _don't need_ all of that power.

== hypermedia is a great idea

Are you actually building a proper web *app*? Like, a photo editor or something? Then
this probably doesn't apply to you. Otherwise, if you are instead building a
plain old content-focused web#strong[site], presumably you are there to present
some information in a compelling fashion. You don't necessarily need all the
systems a framework gives you to implement reactivity, because you aren't
writing an app.

Rather, you're on the web because it offers reach and interactivity that traditional
mediums don't. In other words, you're building a piece of *hypermedia*, or a
non-linear media that branches around itself (because in a web page you can
navigate around in any way you want).

The quintessential language for writing hypermedia--based systems is the
venerable #smallcaps[html], the HyperText Markup Language.

#blockquote(
  attribution: [Carson Gross, in #link("https://hypermedia.systems/hypermedia-a-reintroduction/", "Hypermedia Systems")],
)[
  In a sad turn of events, today, the world’s most popular hypermedia, #smallcaps[html], is
  often viewed resentfully: it is an awkward, legacy markup language that must be
  grudgingly used to build user interfaces in what are increasingly entirely
  JavaScript-based web applications.
]

I recommend you give #link("https://hypermedia.systems/")[Hypermedia Systems] a
read, but to summarize: the Web was designed to present hypermedia to users,
primarily through _hypertext_, a form of hypermedia. Users can interact with
websites through anchor tags (hyperlinks) and other elements, whose purpose
essentially all boils down to making a request to a _hypermedia server_ and
receiving a _hypermedia response_, thus presenting further information to the
user.

This all sounds like a trite restatement of the basic features of the web. Not
so. These are the basic features of the web _precisely because_ hypermedia is
probably the best presentation of the written word on the web we have so far.
Pretty much all content focused websites follow these patterns, and any
attempts to enhance or augment it (like, say, by introducing pop-ups, or AI
summaries, or a hundred other web anti-patterns) almost always results in a
worse experience.

Essentially, once you cut past the artifice and advertising and user retention
hacking of the web, it works most effectively when you have a rich document
that points to other documents, or a hypertext. (A reminder that we are
speaking about websites that seek to present information, not web *apps*. Fully
interactive applications, for example, video editors, require more than just
hypermedia. But for many less or only moderately complex web apps, hypermedia
works great too!)

== digression on web design

Let's briefly talk about the actual visual and UX design of the web itself.
Trust me, this is all going to connect back with hypermedia.

Web developers tend to move in a #quote[cargo cult]. A company doing a brand
refresh or a startup will hire nice designers to create a compelling design
language and nice website. If it's really good, similarly talented people copy
the design, but typically with slightly less thought of why certain elements
were done the way they are. If it really catches on, the style begins to
permeate throughout the rest of the web (especially on new websites built by
rookie web devs). People start crafting #smallcaps[npm] packages so using the
components is as easy as importing a library, partially fueling the ridiculous
#smallcaps[npm] bloat I described earlier.

Case study: #link("https://m3.material.io/")[Material]. A genuinely nice design
system that helped bring the web out of the grungy early 2010s look. But then
it ushered in a wave of sites that all look like an uncanny knockoff of a
Google site (I'd know, because I built one such site a few years ago). Now
React libraries like #link("https://mui.com/material-ui/")[Material UI] make it
zero-effort to drop Material components straight into your app.

More recently, the #link("https://vercel.com/geist/introduction")[Vercel-style]
minimalist design has become popular with startups and indie devs alike.

To be clear, I do not claim that the
web was better prior to the advent of the modern #smallcaps[npm]--centered web design. Rather, the web has
gone from
#link("https://practicaltypography.com/the-bomb-in-the-garden.html")[disgusting]
to #link("https://practicaltypography.com/websites.html")[drab and boring] (not
to mention over--engineered). To quote Mr. Butterick:

#blockquote[
  _Sure, page by page, the web looks better than it did 5 or 10 years ago. But at
  the cost of becoming more homogeneous. We swapped ugly for boring._
]

We went from sites that hurt to look at to sites that all look the same and use
the same few component libraries and design languages. And every site has to
serve a mountain of JavaScript, even if its sole purpose is to render some
#smallcaps[html] that could've just been served directly.

I have no qualms with libraries making Material design components available
easily or people emulating the minimalist Vercel look. But the net effect has
to make _passable_ design available to everyone, creating a homogeneous web
where every site has the same few motifs and styles. Rather than people seeing
designs they like and thoughtfully copying the elements they enjoy, many sites
just end up looking like cheap knockoffs.

== ok, but what does this have to do with hypertext?

The same reason why web design is monotonous and boring today is the same
reason why websites are increasingly written in pure JavaScript with a massive
build pipeline consisting of hundreds of megabytes of source code in
`node_modules` even when complexity is completely unwarranted when considering
their intended purpose.

We started with hypermedia (and in particular, hypertext). These documents were
rendered in ugly, disgusting browser layout engines. Sometime in the mid-2010s,
the baseline of web support reached a critical point where we could start
enhancing hypermedia applications with JavaScript and create truly unique user
experiences that looked great.

And once people experienced decent web design, they wanted to do it too. The
culture of pulling in dependencies that rose around #smallcaps[npm] led to the
incidents like
#link("https://en.wikipedia.org/wiki/Npm_left-pad_incident")[left-pad]
that drew widespread ridicule. But it also had a more subtle effect, in that
everyone's sites started to look and feel more and more alike. Instead of
thinking about intentionality in either design or code, people were more than
happy to import and plumb together thousands of dependencies to end up with a
UI composed of various pre-baked components duct taped together alongside a
massive corpus JavaScript running opaquely in the background, even if they were
just writing something that could work as a few static #smallcaps[html] files.

== so what?

So should you stop using web frameworks immediately and only write raw
#smallcaps[html], and have a website that looks imported from the 90's just
because it's hypermedia and avant--garde?

No, I'm not your dad and I don't care how you make your websites. Keep using
React, or Vue, or whatever hot framework comes next. What matters more is
whether you're building useful software that is pleasant to use and benefits
the public good.

And part of making pleasant and useful software is thinking about what you're
actually building. Does it need to be built in the first place, and does it
need to be built in that way? What I hope to see on the web is more _conscious_
design. The lack of intentionality and care put into the fundamental features
of most websites is the real issue and the rise of copy-pasted UI components
and JavaScript plumbers are just natural symptoms of this fact.

#dinkus

What is the actual fundamental goal of your site? What is the most important
thing users actually get out of it? (I hope you don't answer cynically with a
response like #quote("sign up for the most SaaS subscriptions").) Is
platform-native hypermedia good enough? If you are designing your site in a
certain way, think about _why_ you're adding that hamburger menu dropdown,
_why_ you're putting that navbar there, and _why_ you're importing `200mb` of
JavaScript to do all that.

And if it turns out that hypermedia is all your site really needs, maybe you
don't need that spacetime-distorting `node_modules`, and maybe regular old
#smallcaps[html] will work for you. It certainly works well enough for me.
