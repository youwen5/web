# Apogee

Apogee is a Rust _library_ for writing static site generators centered around
Typst. That is, it is not a batteries-included unified program controlled by
configuration files like e.g. Hexo, Jekyll, etc. It is more in the vein of
Hakyll, in that it provides abstractions for generating static pages.

If you are just looking for a way to write on the web using Typst, consider
[shiroa](https://github.com/Myriad-Dreamin/shiroa), which produces books like
mdBook but written in Typst instead of markdown. If you want a faithful
reproduction (i.e. having the Typst rendering engine output SVGs into the
browser) of Typst documents in the web, consider
[typst.ts](https://myriad-dreamin.github.io/typst.ts/).

Apogee is right for you if you want to build a static, content focused site,
with more complexity/customization than a simple book.

Most development happens on the `dev` branch.
