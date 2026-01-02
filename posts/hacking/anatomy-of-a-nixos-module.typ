---
title: "Anatomy of a NixOS module"
published: 2025-08-31
description: "A not-quite-comprehensive primer on the NixOS module system."
---

// date: datetime(day: 31, year: 2025, month: 8),
// location: "San Francisco, California",
// enable-comments: true,

#import "@preview/html-shim:0.1.0": *

#show: html-shim.with()

NixOS modules are deceptively simple but really quite complicated. Surprisingly
I haven't seen this documented in an easily digestible manner anywhere, so this
serves as an introductory resource.

A "NixOS module" is the standard configuration interface for NixOS, the
Linux distribution (not to be confused with Nix, the package manager). It's
built on the infrastructure in the `nixpkgs` standard library.

All of the NixOS configuration you write will almost
certainly take place in a NixOS module, even if you don't know it at first. Any
external NixOS "flakes" are merely neatly packaged exporters of NixOS
modules. For example, to install home-manager, you import its NixOS module,
exposed at `home-manager.nixosModules.home-manager`.

The most familiar is the standard `/etc/nixos/configuration.nix`. Indeed, this
entire file declares a NixOS module with the very basic configuration for the
system.

In simplest terms, a NixOS module is an attribute set (AttrSet) that can
declare values for NixOS options, or declare new custom NixOS options, or
declare paths to additional NixOS modules to import.

#btw[
  From this point on, this article assumes the reader has basic knowledge of
  the Nix language and its syntax. If you don't---not to fret, the Nix language
  is tiny and quite simple. Familiarize yourself with the basics in
  #link("https://nix.dev/tutorials/nix-language.html")[this article], paying
  particular attention to
  #link("https://nix.dev/tutorials/nix-language.html#attrset")[Attribute Sets
    (AttrSets)] and
  #link("https://nix.dev/tutorials/nix-language.html#functions")[Functions].

  We also assume the user has basic familiarity with NixOS, such as what the
  `pkgs` and `lib` objects are in `configuration.nix`.
]

So what exactly is a NixOS module? At its core, it's a function $f : "AttrSet"
-> "AttrSet"$ that accepts an attribute set with a few parameters, like `pkgs`,
`config`, `lib`, and returns another attribute set declaring configuration
options for NixOS.

When the module is evaluated by a NixOS system build, the module (which, again,
is just a function with a special format) is called, the input parameters are
populated, the options are evaluated, and if there's no issues, the build
proceeds.

#btw[
  A word of advice: the section below will introduce and reintroduce concepts
  in gradually increasing complexity. If you read halfway through, then stop,
  you'll likely be left with a partial/incorrect understanding.
]

= All the ways to declare a NixOS module

Most confusingly, there are actually many "forms" a NixOS module can
take. I said earlier that the module is a function. In fact, this is not
entirely accurate. A NixOS module may be declared as either a function $f :
"AttrSet" -> "AttrSet"$, or simply as an `AttrSet`. This is merely a useful
shorthand in cases where none of the provided parameters are needed.

For example, let's say I want to install `neovim`. I can write this module:

```nix
{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.neovim
  ];
}
```

#btw[
  For the unfamiliar, the `...` syntax at the beginning is a way to ignore the
  rest of the arguments in a function with attribute set arguments. For
  instance, if we omitted the `...`, Nix would complain that the function only
  takes in `pkgs` but is being called with additional parameters like `lib`,
  `config`, etc. as mentioned previously.
]

In this case, we use the full function form, because we want access to the
`pkgs` object to refer to the Neovim package in nixpkgs.

Now suppose we just want to set the time zone to America/Los_Angeles (or
wherever you live). I would write the following module:

```nix
{
  time.timeZone = "America/Los_Angeles";
}
```

Since we just needed to set the option and didn't need any additional
parameters, such the package set, we can simply omit the parameters and write
an AttrSet by itself. Keep in mind that this is just for convenience, the
following snippet would have the exact same effect:

```nix
{ ... }:
{
  time.timeZone = "America/Los_Angeles";
}
```

Ok, that's two ways to declare a NixOS module, are there more? Of course, and
these go beyond simple shorthand. (In fact, we may note that the form of module
declaration shown above is actually shorthand for the module declaration
described below.)

We first need to briefly mention what these options we are setting in our
modules actually are. Above, we set the `time.timeZone` and
`environment.systemPackages` options. These are declared by default in nixpkgs
(where NixOS is implemented), and documented both in the NixOS manual (run
`nixos-help` on a NixOS system), and searchable by selecting #quote[NixOS
  options] on
#link("https://search.nixos.org/options?channel=unstable&")[search.nixos.org].

In the module definitions above, we directly declared values for these options.
This begs the question: can I define my own custom options that I can in turn
use to conditionally control other NixOS options? Of course, but note that
additional custom options are also declared in NixOS modules. To separate the
declaration of the options themselves with the declaration of the values of
existing options, NixOS modules are technically separated into two parts:
`options` and `config`. Maybe it's better to show, not tell in this case.

Here's an example NixOS module where we declare an option to use Helix instead
of Neovim, and then implement it.

```nix
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    useHelixInsteadOfNeovim = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to install Helix instead of Neovim. By default, Neovim will be
        installed. If set to true, Helix will be installed and Neovim will not
        be.
      '';
    };
  };
  config = {
    environment.systemPackages = [
      (if (config.useHelixInsteadOfNeovim) then pkgs.helix else pkgs.neovim)
    ];
  };
}
```

This is quite complicated, so let's break it down. First, we're declaring this
`options` attribute with our custom boolean option, `useHelixInsteadOfNeovim`.
Based on the value of this option, we want to determine whether Neovim or Helix
is added to `environment.systemPackages`.

To do that, we're making use of the `config` parameter. This is an entirely
distinct concept from the `config` attribute we're setting below, so don't
conflate them!

The `config` parameter is available to all NixOS modules and represents the
final, resolved state of the NixOS configuration after all modules are
evaluated. Of course, this is somewhat paradoxical; we are somehow relying on
the final configuration even though it hasn't been finalized, by definition,
until the module is evaluated. These concerns are warranted, and misuse of the
`config` object (usually in self-referential ways) will cause infinite
recursion errors that crash Nix evaluation. In particular, conditional module
imports (i.e. conditionally deciding whether or not to import a NixOS module
based on the `config` object) will almost always cause an infinite recursion
error.

In fact, functional programming buffs may appreciate that the ability to refer
to the final state of an attribute set like the `config` object in this way is
achieved by making the NixOS module a
#link("https://en.wikipedia.org/wiki/Fixed-point_combinator")[fixed-point
  combinator]. Other fixed-point combinators in the nixpkgs standard library
include `stdenv.mkDerivation (finalAttrs: {})` and other similar cases.

If you couldn't understand the previous paragraph, don't worry, it's hardly
relevant to understanding NixOS modules themselves. Anyways, notice that
instead of `environment.systemPackages` being declared in the top level of the
module as we expect, we're declaring it nested one layer deep inside of this
`config` attribute. This is because declaring an `options` attribute in a NixOS
module forces us to declare all of our NixOS option settings in a `config`
attribute instead of at the top level like we're used to.

Finally, inside of the `config` attribute, we declare our familiar
`environment.systemPackages` option, and we use a conditional to check the
value of `config.useHelixInsteadOfNeovim` to determine which one to add to the
list. Again, this `config` AttrSet is passed into the function as a parameter
and refers to the _final state_ of the configuration. Since we declared
`useHelixInsteadOfNeovim` as a custom option, it is of course available inside
this attribute set for us to query the value of.

So this is another way to declare a NixOS module. If you want to add custom
options in a module, you'll have to declare an `options` and `config` objects,
then declare all of your familiar NixOS options in the `config` object. From
this point of view, the simple NixOS module declaration from before is actually
just a shorthand for declaring `config = {...}` without declaring any new
options.

To really hammer this point home, note that

```nix
{
  pkgs,
  ...
}:
{
  environment.systemPackages = [ pkgs.neovim ];
}
```

is entirely equivalent to

```nix
{
  pkgs,
  ...
}:
{
  config = {
    environment.systemPackages = [ pkgs.neovim ];
  };
}
```

The first is simply shorthand for the second. However, if we were to declare a custom option,

```nix
{
  pkgs,
  ...
}:
{
  options = {
    myCustomOption = {
      # --- snip ---
    };
  };
  config = {
    environment.systemPackages = [ pkgs.neovim ];
  };
}
```

Then we _must_ declare our values in the `config` attribute. The following is *invalid*.

```nix
{
  pkgs,
  ...
}:
{
  options = {
    myCustomOption = {
      # --- snip ---
    };
  };
  # This is invalid! By declaring `options`, we must declare `config`, and we
  # cannot directly declare this here.
  environment.systemPackages = [ pkgs.neovim ];
}
```

There is one last part of a NixOS module that I must mention. `imports` is the
third top-level module attribute---that is, it is always declared at the top
level of the attribute set, even if `options` and `config` are used. `imports`
is just a list of additional NixOS modules to include and evaluate.

```nix
{
  imports = [
    ./my-module.nix
  ];
  options = {
    myOption = {
      # -- snip --
    };
  };
  config = {
    # -- snip --
  };
}
```

Even when `options` is not set, it is can still be declared top level alongside
all the other options.

```nix
{
  imports = [
    ./my-module.nix
  ];
  time.timeZone = "America/Los_Angeles";
}
```

#dinkus

OK---I think we can briefly summarize the full story of a NixOS module now. We
started off with the simplest understanding and gradually introduced more
complex features. From our elevated point of view, we can describe a NixOS
module as such.

A NixOS module is either a function $f : "AttrSet" -> "AttrSet"$, or, if none
of the parameters are needed, just an AttrSet. The returned AttrSet is split
into three top level attributes: `imports`, `options`, and `config`. `imports`
is an optional array of other NixOS modules that should be included and
evaluated. `options` is an AttrSet of additional NixOS modules to declare.
`config` is an AttrSet of that sets values for arbitrary NixOS options, as
defined by default or other custom options.

If we aren't declaring any new options, we can omit the `options` attribute,
and thus we can directly declare our `config` options in the top level.
Otherwise, if we are setting `options`, we must set our configuration in
`config`.

The parameters provided to each module include `lib`, the nixpkgs standard
library, `pkgs`, the package set of the system, and `config`, an AttrSet
representing the final configuration of the system after all modules evaluate.
There are other parameters, but we won't mention them here.

#btw[
  What about home-manager? home-manager modules heavily mimic NixOS
  modules. In fact, we can basically think of them exactly the same way, except
  with the home-manager options rather than NixOS options. Likewise, the `config`
  AttrSet provided to each module is the final home-manager configuration, rather
  than the NixOS configuration. One additional parameter of note is `osConfig`,
  which exists if and only if home-manager is installed as part of a NixOS
  configuration and not a standalone program. `osConfig` provides an AttrSet
  representing the NixOS configuration the home-manager configuration is part
  of---it is essentially the `config` object that would be provided to a NixOS
  module in the configuration.
]

= Further reading

- #link("https://wiki.nixos.org/wiki/NixOS_modules")[NixOS wiki]
- #link(
    "https://nix.dev/tutorials/module-system/",
  )[An in-depth (3 hours) deep dive on nix.dev]
