#import "@preview/html-shim:0.1.0": *

#show: html-shim

$m$-reductions are tricky for students to wrap their heads around at first. To
show a given relation $A$ is undecidable, it suffices to show that the
(diagonal) *Halting Problem* $Kappa$ reduces to *it*. The relation is denoted
$
  Kappa attach(<=, br: m) m.
$
This is converse to what you need to do when you prove that $B$ is decidable given that $C$ is decidable. In this case, we need to show a reduction from $B$ to $C$, that is
$
  B attach(<=, br: m) C.
$
It's pretty obvious why the order reverses when you say it out loud: if $C$ is
decidable, then if deciding $B$ can be (computably) reduced to deciding $C$, we
can obviously decide $B$. In a sense, we want to show that deciding $B$ is an
_easier_ problem that $C$.

When showing undecidability, we reverse this relationship. To show that $A$ is
undecidable from $Kappa$, it does not suffice to reduce $A$ to $Kappa$, since
this only shows that deciding halting also decides $A$, so $A$ is _easier_ than
$Kappa$ in the same sense as earlier. However, this doesn't mean that $A$ is
undecidable, as $A$ could very well be sufficiently easier than $Kappa$ to be
decidable. Therefore, we need to actually show a reduction from $Kappa$ to $A$:
deciding $A$ would allow you to decide $Kappa$, so $Kappa$ is easier than $A$.
But $Kappa$ is already undecidable, so a harder problem $A$ would still be
undecidable.
