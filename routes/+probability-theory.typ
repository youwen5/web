#import "@luminite/html-shim:0.1.0": *

#show: html-shim.with(
  date: datetime(
    day: 16,
    year: 2025,
    month: 2,
  ),
  title: "Probability distributions",
  meta-description: "Notes I've been collecting on random variables, their
distributions, expected values, and moment generating functions.",
)
#let callout = type => (title: "", content) => [
  #if title != "" [
    _#type (#title)._
  ] else [
    _#type. _
  ]
  #content
]

#let fact = callout("Fact")
#let thm = callout("Theorem")
#let proof = callout("Proof")
#let remark = callout("Remark")
#let definition = callout("Definition")
#let abuse = callout("Abuse of notation")
#let exercise = callout("Exercise")
#let example = callout("Example")

These are some notes I've been collecting on random variables, their
distributions, expected values, and moment generating functions. I thought I'd
write them down somewhere useful.

These are almost extracted verbatim from my in-class notes, which I take in real
time using Typst. This is probably not that useful to anyone and mainly just
here to showcase how an entire Typst document can render to a webpage.

#dinkus

== Random variables

First, some brief exposition on random variables. Quixotically, a random
variable is actually a function.

Standard notation: $Omega$ is a sample space, $omega in Omega$ is an event.

#definition[
  A *random variable* $X$ is a function $X : Omega -> RR$ that takes the set of
  possible outcomes in a sample space, and maps it to a
  #link("https://en.wikipedia.org/wiki/Measurable_space")[measurable space],
  typically (as in our case) a subset of $RR$.
]

#definition[
  The *state space* of a random variable $X$ is all of the values $X$ can take.
]

#example[
  Let $X$ be a random variable that takes on the values ${0,1,2,3}$. Then the
  state space of $X$ is the set ${0,1,2,3}$.
]

=== Discrete random variables

A random variable $X$ is discrete if there is countable $A$ such that $P(X in
  A) = 1$. $k$ is a possible value if $P(X = k) > 0$. We discuss continuous
random variables later.

The _probability distribution_ of $X$ gives its important probabilistic
information. The probability distribution is a description of the probabilities
$P(X in B)$ for subsets $B in RR$. We describe the probability density function
and the cumulative distribution function.

A discrete random variable has probability distribution entirely determined by
its probability mass function (hereafter abbreviated p.m.f or PMF) $p(k) = P(X
  = k)$. The p.m.f. is a function from the set of possible values of $X$ into
$[0,1]$. Labeling the p.m.f. with the random variable is done by $p_X (k)$.

$
  p_X : "State space of" X -> [0,1]
$

By the axioms of probability,

$
  sum_k p_X (k) = sum_k P(X=k) = 1
$

For a subset $B subset RR$,

$
  P(X in B) = sum_(k in B) p_X (k)
$

=== Continuous random variables

Now as promised we introduce another major class of random variables.

#definition[
  Let $X$ be a random variable. If $f$ satisfies

  $
    P(X <= b) = integral^b_(-infinity) f(x) dif x
  $

  for all $b in RR$, then $f$ is the *probability density function* (hereafter
  abbreviated p.d.f. or PDF) of $X$.
]

We immediately see that the p.d.f. is analogous to the p.m.f. of the discrete case.

The probability that $X in (-infinity, b]$ is equal to the area under the graph
of $f$ from $-infinity$ to $b$.

A corollary is the following.

#fact[
  $ P(X in B) = integral_B f(x) dif x $
]

for any $B subset RR$ where integration makes sense.

The set can be bounded or unbounded, or any collection of intervals.

#fact[
  $ P(a <= X <= b) = integral_a^b f(x) dif x $
  $ P(X > a) = integral_a^infinity f(x) dif x $
]

#fact[
  If a random variable $X$ has density function $f$ then individual point
  values have probability zero:

  $ P(X = c) = integral_c^c f(x) dif x = 0, forall c in RR $
]

#remark[
  It follows a random variable with a density function is not discrete. An
  immediate corollary of this is that the probabilities of intervals are not
  changed by including or excluding endpoints. So $P(X <= k)$ and $P(X < k)$ are equivalent.
]

How to determine which functions are p.d.f.s? Since $P(-infinity < X <
  infinity) = 1$, a p.d.f. $f$ must satisfy

$
  f(x) >= 0 forall x in RR \
  integral^infinity_(-infinity) f(x) dif x = 1
$

#fact[
  Random variables with density functions are called _continuous_ random
  variables. This does not imply that the random variable is a continuous
  function on $Omega$ but it is standard terminology.
]

== Discrete distributions

Recall that the _probability distribution_ of $X$ gives its important probabilistic
information. Let us discuss some of these distributions.

In general we first consider the experiment's properties and theorize about the
distribution that its random variable takes. We can then apply the distribution
to find out various pieces of probabilistic information.

=== Bernoulli trials

A Bernoulli trial is the original "experiment." It's simply a single trial with
a binary "success" or "failure" outcome. Encode this T/F, 0 or 1, or however
you'd like. It becomes immediately useful in defining more complex
distributions, so let's analyze its properties.

The setup: the experiment has exactly two outcomes:
- Success -- $S$ or 1
- Failure -- $F$ or 0

Additionally:
$
  P(S) = p, (0 < p < 1) \
  P(F) = 1 - p = q
$

Construct the probability mass function:

$
  P(X = 1) = p \
  P(X = 0) = 1 - p
$

Write it as:

$ p_x(k) = p^k (1-p)^(1-k) $

for $k = 1$ and $k = 0$.

=== Binomial distribution

The setup: very similar to Bernoulli, trials have exactly 2 outcomes. A bunch
of Bernoulli trials in a row.

Importantly: $p$ and $q$ are defined exactly the same in all trials.

This ties the binomial distribution to the sampling with replacement model,
since each trial does not affect the next.

We conduct $n$ *independent* trials of this experiment. Example with coins: each
flip independently has a $1 / 2$ chance of heads or tails (holds same for die,
rigged coin, etc).

$n$ is fixed, i.e. known ahead of time.

==== Binomial random variable

Let's consider the random variable characterized by the binomial distribution now.

Let $X = hash$ of successes in $n$ independent trials. For any particular
sequence of $n$ trials, it takes the form $Omega = {omega} "where" omega = S
F F dots.c F$ and is of length $n$.

Then $X(omega) = 0,1,2,...,n$ can take $n + 1$ possible values. The
probability of any particular sequence is given by the product of the
individual trial probabilities.

#example[
  $ omega = S F F S F dots.c S = (p q q p q dots.c p) $
]

So $P(x = 0) = P(F F F dots.c F) = q dot q dot dots.c dot q = q^n$.

And
$
  P(X = 1) = P(S F F dots.c F) + P(F S F F dots.c F) + dots.c + P(F F F dots.c F S) \
  = underbrace(n, "possible outcomes") dot p^1 dot p^(n-1) \
  = vec(n, 1) dot p^1 dot p^(n-1) \
  = n dot p^1 dot p^(n-1)
$

Now we can generalize

$
  P(X = 2) = vec(n, 2) p^2 q^(n-2)
$

How about all successes?

$
  P(X = n) = P(S S dots.c S) = p^n
$

We see that for all failures we have $q^n$ and all successes we have $p^n$.
Otherwise we use our method above.

In general, here is the probability mass function for the binomial random variable

$
  P(X = k) = vec(n, k) p^k q^(n-k), "for" k = 0,1,2,...,n
$


Binomial distribution is very powerful. Choosing between two things, what are the probabilities?

To summarize the characterization of the binomial random variable:

- $n$ independent trials
- each trial results in binary success or failure
- with probability of success $p$, identically across trials

with $X = hash$ successes in *fixed* $n$ trials.

$ X ~ "Bin"(n,p) $

with probability mass function

$
  P(X = x) = vec(n, x) p^x (1 - p)^(n-x) = p(x) "for" x = 0,1,2,...,n
$

We see this is in fact the binomial theorem!

$
  p(x) >= 0, sum^n_(x=0) p(x) = sum^n_(x=0) vec(n, x) p^x q^(n-x) = (p + q)^n
$

In fact,
$
  (p + q)^n = (p + (1 - p))^n = 1
$

#example[
  What is the probability of getting exactly three aces (1's) out of 10 throws
  of a fair die?

  Seems a little trickier but we can still write this as well defined $S$/$F$.
  Let $S$ be getting an ace and $F$ being anything else.

  Then $p = 1 / 6$ and $n = 10$. We want $P(X=3)$. So

  $
    P(X=3) = vec(10, 3) p^3 q^7 = vec(10, 3) (1 / 6)^3 (5 / 6)^7 \
    approx 0.15505
  $
]

==== With or without replacement?

I place particular emphasis on the fact that the binomial distribution
generally applies to cases where you're sampling with _replacement_. Consider
the following:
#example[
  Suppose we have two types of candy, red and black. Select $n$ candies. Let $X$
  be the number of red candies among $n$ selected.

  2 cases.

  - case 1: with replacement: Binomial Distribution, $n$, $p = a / (a + b)$.
  $ P(X = 2) = vec(n, 2) (a / (a+b))^2 (b / (a+b))^(n-2) $
  - case 2: without replacement: then use counting
  $ P(X = x) = (vec(a, x) vec(b, n-x)) / vec(a+b, n) = p(x) $
]

In case 2, we used the elementary counting techniques we are already familiar
with. Immediately we see a distinct case similar to the binomial but when
sampling without replacement. Let's formalize this as a random variable!

=== Hypergeometric distribution

Let's introduce a random variable to represent a situation like case 2 above.

#definition[
  $ P(X = x) = (vec(a, x) vec(b, n-x)) / vec(a+b, n) = p(x) $

  is known as a *Hypergeometric distribution*.
]

Abbreviate this by:

$ X ~ "Hypergeom"(hash "total", hash "successes", "sample size") $

For example,

$ X ~ "Hypergeom"(N, N_a, n) $

#remark[
  If $x$ is very small relative to $a + b$, then both cases give similar (approx.
  the same) answers.
]

For instance, if we're sampling for blood types from UCSB, and we take a
student out without replacement, we don't really change the sample size
substantially. So both answers give a similar result.

Suppose we have two types of items, type $A$ and type $B$. Let $N_A$ be $hash$
type $A$, $N_B$ $hash$ type $B$. $N = N_A + N_B$ is the total number of
objects.

We sample $n$ items *without replacement* ($n <= N$) with order not mattering.
Denote by $X$ the number of type $A$ objects in our sample.

#definition[
  Let $0 <= N_A <= N$ and $1 <= n <= N$ be integers. A random variable $X$ has the *hypergeometric distribution* with parameters $(N, N_A, n)$ if $X$ takes values in the set ${0,1,...,n}$ and has p.m.f.

  $ P(X = k) = (vec(N_A, k) vec(N-N_A, n-k)) / vec(N, n) = p(k) $
]

#example[
  Let $N_A = 10$ defectives. Let $N_B = 90$ non-defectives. We select $n=5$ without replacement. What is the probability that 2 of the 5 selected are defective?

  $
    X ~ "Hypergeom" (N = 100, N_A = 10, n = 5)
  $

  We want $P(X=2)$.

  $
    P(X=2) = (vec(10, 2) vec(90, 3)) / vec(100, 5) approx 0.0702
  $
]

#remark[
  Make sure you can distinguish when a problem is binomial or when it is
  hypergeometric. This is very important on exams.

  Recall that both ask about number of successes, in a fixed number of trials.
  But binomial is sample with replacement (each trial is independent) and
  sampling without replacement is hypergeometric.
]

=== Geometric distribution

Consider an infinite sequence of independent trials. e.g. number of attempts until I make a basket.

In fact we can think of this as a variation on the binomial distribution.
But in this case we don't sample $n$ times and ask how many successes we have,
we sample as many times as we need for _one_ success. Later on we'll see this
is really a specific case of another distribution, the _negative binomial_.

Let $X_i$ denote the outcome of the $i^"th"$ trial, where success is 1 and
failure is 0. Let $N$ be the number of trials needed to observe the first
success in a sequence of independent trials with probability of success $p$.
Then

We fail $k-1$ times and succeed on the $k^"th"$ try. Then:

$
  P(N = k) = P(X_1 = 0, X_2 = 0, ..., X_(k-1) = 0, X_k = 1) = (1 - p)^(k-1) p
$

This is the probability of failures raised to the amount of failures, times
probability of success.

The key characteristic in these trials, we keep going until we succeed. There's
no $n$ choose $k$ in front like the binomial distribution because there's
exactly one sequence that gives us success.

#definition[
  Let $0 < p <= 1$. A random variable $X$ has the geometric distribution with
  success parameter $p$ if the possible values of $X$ are ${1,2,3,...}$ and $X$
  satisfies

  $
    P(X=k) = (1-p)^(k-1) p
  $

  for positive integers $k$. Abbreviate this by $X ~ "Geom"(p)$.
]

#example[
  What is the probability it takes more than seven rolls of a fair die to roll a
  six?

  Let $X$ be the number of rolls of a fair die until the first six. Then $X ~
  "Geom"(1 / 6)$. Now we just want $P(X > 7)$.

  $
    P(X > 7) = sum^infinity_(k=8) P(X=k) = sum^infinity_(k=8) (5 / 6)^(k-1) 1 / 6
  $

  Re-indexing,

  $
    sum^infinity_(k=8) (5 / 6)^(k-1) 1 / 6 = 1 / 6 (5 / 6)^7 sum^infinity_(j=0) (5 / 6)^j
  $

  Now we calculate by standard methods:

  $
    1 / 6 (5 / 6)^7 sum^infinity_(j=0) (5 / 6)^j = 1 / 6 (5 / 6)^7 dot 1 / (1-5 / 6) =
    (5 / 6)^7
  $
]

=== Negative binomial

As promised, here's the negative binomial.

Consider a sequence of Bernoulli trials with the following characteristics:

- Each trial success or failure
- Prob. of success $p$ is same on each trial
- Trials are independent (notice they are not fixed to specific number)
- Experiment continues until $r$ successes are observed, where $r$ is a given parameter

Then if $X$ is the number of trials necessary until $r$ successes are observed,
we say $X$ is a *negative binomial* random variable.

Immediately we see that the geometric distribution is just the negative binomial with $r = 1$.

#definition[
  Let $k in ZZ^+$ and $0 < p <= 1$. A random variable $X$ has the negative
  binomial distribution with parameters ${k,p}$ if the possible values of $X$
  are the integers ${k,k+1, k+2, ...}$ and the p.m.f. is

  $
    P(X = n) = vec(n-1, k-1) p^k (1-p)^(n-k) "for" n >= k
  $

  Abbreviate this by $X ~ "Negbin"(k,p)$.
]

#example[
  Steph Curry has a three point percentage of approx. $43%$. What is the
  probability that Steph makes his third three-point basket on his $5^"th"$
  attempt?

  Let $X$ be number of attempts required to observe the 3rd success. Then,

  $
    X ~ "Negbin"(k = 3, p = 0.43)
  $

  So,
  $
    P(X = 5) &= vec(5-1, 3-1)(0.43)^3 (1 - 0.43)^(5-3) \
    &= vec(4, 2) (0.43)^3 (0.57)^2 \
    &approx 0.155
  $
]

=== Poisson distribution

This p.m.f. follows from the Taylor expansion

$
  e^lambda = sum_(k=0)^infinity lambda^k / k!
$

which implies that

$
  sum_(k=0)^infinity e^(-lambda) lambda^k / k! = e^(-lambda) e^lambda = 1
$

#definition[
  For an integer valued random variable $X$, we say $X ~ "Poisson"(lambda)$ if it has p.m.f.

  $ P(X = k) = e^(-lambda) lambda^k / k! $

  for $k in {0,1,2,...}$ for $lambda > 0$ and

  $
    sum_(k = 0)^infinity P(X=k) = 1
  $
]

The Poisson arises from the Binomial. It applies in the binomial context when
$n$ is very large ($n >= 100$) and $p$ is very small $p <= 0.05$, such that $n
p$ is a moderate number ($n p < 10$).

Then $X$ follows a Poisson distribution with $lambda = n p$.

$
  P("Bin"(n,p) = k) approx P("Poisson"(lambda = n p) = k)
$

for $k = 0,1,...,n$.

The Poisson distribution is useful for finding the probabilities of rare events
over a continuous interval of time. By knowing $lambda = n p$ for small $n$ and
$p$, we can calculate many probabilities.

#example[
  The number of typing errors in the page of a textbook.

  Let

  - $n$ be the number of letters of symbols per page (large)
  - $p$ be the probability of error, small enough such that
  - $lim_(n -> infinity) lim_(p -> 0) n p = lambda = 0.1$

  What is the probability of exactly 1 error?

  We can approximate the distribution of $X$ with a $"Poisson"(lambda = 0.1)$
  distribution

  $
    P(X = 1) = (e^(-0.1) (0.1)^1) / 1! = 0.09048
  $
]

== Continuous distributions

All of the distributions we've been analyzing have been discrete, that is, they
apply to random variables with a
#link("https://en.wikipedia.org/wiki/Countable_set")[countable] state space.
Even when the state space is infinite, as in the negative binomial, it is
countable. We can think of it as indexing each trial with a natural number
$0,1,2,3,...$.

Now we turn our attention to continuous random variables that operate on
uncountably infinite state spaces. For example, if we sample uniformly inside
of the interval $[0,1]$, there are an uncountably infinite number of possible
values we could obtain. We cannot index these values by the natural numbers, by
some theorems of set theory we in fact know that the interval $[0,1]$ has a
bijection to $RR$ and has cardinality $aleph_1$.

Additionally we notice that asking for the probability that we pick a certain
point in the interval $[0,1]$ makes no sense, there are an infinite amount of
sample points! Intuitively we should think that the probability of choosing any
particular point is 0. However, we should be able to make statements about
whether we can choose a point that lies within a subset, like $[0,0.5]$.

Let's formalize these ideas.

#definition[
  Let $X$ be a random variable. If we have a function $f$ such that

  $
    P(X <= b) = integral^b_(-infinity) f(x) dif x
  $
  for all $b in RR$, then $f$ is the *probability density function* of $X$.
]

The probability that the value of $X$ lies in $(-infinity, b]$ equals the area
under the curve of $f$ from $-infinity$ to $b$.

If $f$ satisfies this definition, then for any $B subset RR$ for which integration makes sense,

$
  P(X in B) = integral_B f(x) dif x
$

#remark[
  Recall from our previous discussion of random variables that the PDF is the
  analogue of the PMF for discrete random variables.
]

Properties of a CDF:

Any CDF $F(x) = P(X <= x)$ satisfies

1. Integrates to unity: $F(-infinity) = 0$, $F(infinity) = 1$
2. $F(x)$ is non-decreasing in $x$ (monotonically increasing)
$ s < t => F(s) <= F(t) $
3. $P(a < X <= b) = P(X <= b) - P(X <= a) = F(b) - F(a)$

Like we mentioned before, we can only ask about things like $P(X <= k)$, but
not $P(X = k)$. In fact $P(X = k) = 0$ for all $k$. An immediate corollary of
this is that we can freely interchange $<=$ and $<$ and likewise for $>=$ and
$>$, since $P(X <= k) = P(X < k)$ if $P(X = k) = 0$.

#example[
  Let $X$ be a continuous random variable with density (pdf)

  $
    f(x) = cases(
      c x^2 &"for" 0 < x < 2,
      0 &"otherwise"
    )
  $

  1. What is $c$?

  $c$ is such that
  $
    1 = integral^infinity_(-infinity) f(x) dif x = integral_0^2 c x^2 dif x
  $

  2. Find the probability that $X$ is between 1 and 1.4.

  Integrate the curve between 1 and 1.4.

  $
    integral_1^1.4 3 / 8 x^2 dif x = (x^3 / 8) |_1^1.4 \
    = 0.218
  $

  This is the probability that $X$ lies between 1 and 1.4.

  3. Find the probability that $X$ is between 1 and 3.

  Idea: integrate between 1 and 3, be careful after 2.

  $ integral^2_1 3 / 8 x^2 dif x + integral_2^3 0 dif x = $

  4. What is the CDF for $P(X <= x)$? Integrate the curve to $x$.

  $
    F(x) = P(X <= x) = integral_(-infinity)^x f(t) dif t \
    = integral_0^x 3 / 8 t^2 dif t \
    = x^3 / 8
  $

  Important: include the range!

  $
    F(x) = cases(
      0 &"for" x <= 0,
      x^3 / 8 &"for" 0 < x < 2,
      1 &"for" x >= 2
    )
  $

  5. Find a point $a$ such that you integrate up to the point to find exactly $1 / 2$
  the area.

  We want to find $1 / 2 = P(X <= a)$.

  $ 1 / 2 = P(X <= a) = F(a) = a^3 / 8 => a = root(3, 4) $
]

Now let us discuss some named continuous distributions.

=== The (continuous) uniform distribution

The most simple and the best of the named distributions!

#definition[
  Let $[a,b]$ be a bounded interval on the real line. A random variable $X$ has the uniform distribution on the interval $[a,b]$ if $X$ has the density function

  $
    f(x) = cases(
      1 / (b-a) &"for" x in [a,b],
      0 &"for" x in.not [a,b]
    )
  $

  Abbreviate this by $X ~ "Unif" [a,b]$.
]<continuous-uniform>

The graph of $"Unif" [a,b]$ is a constant line at height $1 / (b-a)$ defined
across $[a,b]$. The integral is just the area of a rectangle, and we can check
it is 1.

#fact[
  For $X ~ "Unif" [a,b]$, its cumulative distribution function (CDF) is given by:

  $
    F_x (x) = cases(
      0 &"for" x < a,
      (x-a) / (b-a) &"for" x in [a,b],
      1 &"for" x > b
    )
  $
]

#fact[
  If $X ~ "Unif" [a,b]$, and $[c,d] subset [a,b]$, then
  $
    P(c <= X <= d) = integral_c^d 1 / (b-a) dif x = (d-c) / (b-a)
  $
]

#example[
  Let $Y$ be a uniform random variable on $[-2,5]$. Find the probability that its
  absolute value is at least 1.

  $Y$ takes values in the interval $[-2,5]$, so the absolute value is at least 1 iff. $Y in [-2,1] union [1,5]$.

  The density function of $Y$ is $f(x) = 1 / (5- (-2)) = 1 / 7$ on $[-2,5]$ and 0 everywhere else.

  So,

  $
    P(|Y| >= 1) &= P(Y in [-2,-1] union [1,5]) \
    &= P(-2 <= Y <= -1) + P(1 <= Y <= 5) \
    &= 5 / 7
  $
]

=== The exponential distribution

The geometric distribution can be viewed as modeling waiting times, in a discrete setting, i.e. we wait for $n - 1$ failures to arrive at the $n^"th"$ success.

The exponential distribution is the continuous analogue to the geometric
distribution, in that we often use it to model waiting times in the continuous
sense. For example, the first custom to enter the barber shop.

#definition[
  Let $0 < lambda < infinity$. A random variable $X$ has the exponential distribution with parameter $lambda$ if $X$ has PDF

  $
    f(x) = cases(
      lambda e^(-lambda x) &"for" x >= 0,
      0 &"for" x < 0
    )
  $

  Abbreviate this by $X ~ "Exp"(lambda)$, the exponential distribution with rate $lambda$.

  The CDF of the $"Exp"(lambda)$ distribution is given by:

  $
    F(t) + cases(
      0 &"if" t <0,
      1 - e^(-lambda t) &"if" t>= 0
    )
  $
]

#example[
  Suppose the length of a phone call, in minutes, is well modeled by an exponential random variable with a rate $lambda = 1 / 10$.

  1. What is the probability that a call takes more than 8 minutes?
  2. What is the probability that a call takes between 8 and 22 minutes?

  Let $X$ be the length of the phone call, so that $X ~ "Exp"(1 / 10)$. Then we can find the desired probability by:

  $
    P(X > 8) &= 1 - P(X <= 8) \
    &= 1 - F_x (8) \
    &= 1 - (1 - e^(-(1 / 10) dot 8)) \
    &= e^(-8 / 10) approx 0.4493
  $

  Now to find $P(8 < X < 22)$, we can take the difference in CDFs:

  $
    &P(X > 8) - P(X >= 22) \
    &= e^(-8 / 10) - e^(-22 / 10) \
    &approx 0.3385
  $
]

#fact(title: "Memoryless property of the exponential distribution")[
  Suppose that $X ~ "Exp"(lambda)$. Then for any $s,t > 0$, we have
  $
    P(X > t + s | X > t) = P(X > s)
  $
]<memoryless>

This is like saying if I've been waiting 5 minutes and then 3 minutes for the
bus, what is the probability that I'm gonna wait more than 5 + 3 minutes, given
that I've already waited 5 minutes? And that's precisely equal to just the
probability I'm gonna wait more than 3 minutes.

#proof[
  $
    P(X > t + s | X > t) = (P(X > t + s inter X > t)) / (P(X > t)) \
    = P(X > t + s) / P(X > t)
    = e^(-lambda (t+ s)) / (e^(-lambda t)) = e^(-lambda s) \
    equiv P(X > s)
  $
]

=== Gamma distribution

#definition[
  Let $r, lambda > 0$. A random variable $X$ has the *gamma distribution* with parameters $(r, lambda)$ if $X$ is nonnegative and has probability density function

  $
    f(x) = cases(
      (lambda^r x^(r-2)) / (Gamma(r)) e^(-lambda x) &"for" x >= 0,
      0 &"for" x < 0
    )
  $

  Abbreviate this by $X ~ "Gamma"(r, lambda)$.
]

The gamma function $Gamma(r)$ generalizes the factorial function and is defined as

$
  Gamma(r) = integral_0^infinity x^(r-1) e^(-x) dif x, "for" r > 0
$

Special case: $Gamma(n) = (n - 1)!$ if $n in ZZ^+$.

#remark[
  The $"Exp"(lambda)$ distribution is a special case of the gamma distribution,
  with parameter $r = 1$.
]

== The normal distribution

Also known as the Gaussian distribution, this is so important it gets its own section.

#definition[
  A random variable $Z$ has the *standard normal distribution* if $Z$ has
  density function

  $
    phi(x) = 1 / sqrt(2 pi) e^(-x^2 / 2)
  $
  on the real line. Abbreviate this by $Z ~ N(0,1)$.
]<normal-dist>

#fact(title: "CDF of a standard normal random variable")[
  Let $Z~N(0,1)$ be normally distributed. Then its CDF is given by
  $
    Phi(x) = integral_(-infinity)^x phi(s) dif s = integral_(-infinity)^x 1 / sqrt(2 pi) e^(-(-s^2) / 2) dif s
  $
]

The normal distribution is so important, instead of the standard $f_Z(x)$ and
$F_z(x)$, we use the special $phi(x)$ and $Phi(x)$.

#fact[
  $
    integral_(-infinity)^infinity e^(-s^2 / 2) dif s = sqrt(2 pi)
  $

  No closed form of the standard normal CDF $Phi$ exists, so we are left to either:
  - approximate
  - use technology (calculator)
  - use the standard normal probability table in the textbook
]

To evaluate negative values, we can use the symmetry of the normal distribution
to apply the following identity:

$
  Phi(-x) = 1 - Phi(x)
$

=== General normal distributions

We can compute any other parameters of the normal distribution using the
standard normal.

The general family of normal distributions is obtained by linear or affine
transformations of $Z$. Let $mu$ be real, and $sigma > 0$, then

$
  X = sigma Z + mu
$
is also a normally distributed random variable with parameters $(mu, sigma^2)$.
The CDF of $X$ in terms of $Phi(dot)$ can be expressed as

$
  F_X (x) &= P(X <= x) \
  &= P(sigma Z + mu <= x) \
  &= P(Z <= (x - mu) / sigma) \
  &= Phi((x-mu) / sigma)
$

Also,

$
  f(x) = F'(x) = dif / (dif x) [Phi((x-u) / sigma)] = 1 / sigma phi((x-u) / sigma) = 1 / sqrt(2 pi sigma^2) e^(-((x-mu)^2) / (2sigma^2))
$

#definition[
  Let $mu$ be real and $sigma > 0$. A random variable $X$ has the _normal distribution_ with mean $mu$ and variance $sigma^2$ if $X$ has density function

  $
    f(x) = 1 / sqrt(2 pi sigma^2) e^(-((x-mu)^2) / (2sigma^2))
  $

  on the real line. Abbreviate this by $X ~ N(mu, sigma^2)$.
]

#fact[
  Let $X ~ N(mu, sigma^2)$ and $Y = a X + b$. Then
  $
    Y ~ N(a mu + b, a^2 sigma^2)
  $

  That is, $Y$ is normally distributed with parameters $(a mu + b, a^2 sigma^2)$.
  In particular,
  $
    Z = (X - mu) / sigma ~ N(0,1)
  $
  is a standard normal variable.
]

== Expectation

Let's discuss the _expectation_ of a random variable, which is a similar idea
to the basic concept of _mean_.

#definition[
  The expectation or mean of a discrete random variable $X$ is the weighted
  average, with weights assigned by the corresponding probabilities.

  $
    E(X) = sum_("all" x_i) x_i dot p(x_i)
  $
]

#example[
  Find the expected value of a single roll of a fair die.

  - $X = "score" / "dots"$
  - $x = 1,2,3,4,5,6$
  - $p(x) = 1 / 6, 1 / 6,1 / 6,1 / 6,1 / 6,1 / 6$

  $
    E[x] = 1 dot 1 / 6 + 2 dot 1 / 6 ... + 6 dot 1 / 6
  $
]

=== Binomial expected value

$
  E[x] = n p
$

=== Bernoulli expected value

Bernoulli is just binomial with one trial.

Recall that $P(X=1) = p$ and $P(X=0) = 1 - p$.

$
  E[X] = 1 dot P(X=1) + 0 dot P(X=0) = p
$

Let $A$ be an event on $Omega$. Its _indicator random variable_ $I_A$ is defined
for $omega in Omega$ by

$
  I_A (omega) = cases(1", if " &omega in A, 0", if" &omega in.not A)
$

$
  E[I_A] = 1 dot P(A) = P(A)
$

== Geometric expected value

Let $p in [0,1]$ and $X ~ "Geom"[ p ]$ be a geometric RV with probability of
success $p$. Recall that the p.m.f. is $p q^(k-1)$, where prob. of failure is defined by $q := 1-p$.

Then

$
  E[X] &= sum_(k=1)^infinity k p q^(k-1) \
  &= p dot sum_(k=1)^infinity k dot q^(k-1)
$

Now recall from calculus that you can differentiate a power series term by term inside its radius of convergence. So for $|t| < 1$,

$
  sum_(k=1)^infinity k t^(k-1) =
  sum_(k=1)^infinity dif / (dif t) t^k = dif / (dif t) sum_(k=1)^infinity t^k = dif / (dif t) (1 / (1-t)) = 1 / (1-t)^2 \
  therefore E[x] = sum^infinity_(k=1) k p q^(k-1) = p sum^infinity_(k=1) k q^(k-1) = p (1 / (1 - q)^2) = 1 / p
$

=== Expected value of a continuous RV

#definition[
  The expectation or mean of a continuous random variable $X$ with density
  function $f$ is

  $
    E[x] = integral_(-infinity)^infinity x dot f(x) dif x
  $

  An alternative symbol is $mu = E[x]$.
]

$mu$ is the "first moment" of $X$, analogous to physics, it's the "center of
gravity" of $X$.

#remark[
  In general when moving between discrete and continuous RV, replace sums with
  integrals, p.m.f. with p.d.f., and vice versa.
]

#example[
  Suppose $X$ is a continuous RV with p.d.f.

  $
    f_X (x) = cases(2x", " &0 < x < 1, 0"," &"elsewhere")
  $

  $
    E[X] = integral_(-infinity)^infinity x dot f(x) dif x = integral^1_0 x dot 2x dif x = 2 / 3
  $
]

#example(title: "Uniform expectation")[
  Let $X$ be a uniform random variable on the interval $[a,b]$ with $X ~
  "Unif"[a,b]$. Find the expected value of $X$.

  $
    E[X] = integral^infinity_(-infinity) x dot f(x) dif x = integral_a^b x / (b-a) dif x \
    = 1 / (b-a) integral_a^b x dif x = 1 / (b-a) dot (b^2 - a^2) / 2 = underbrace((b+a) / 2, "midpoint formula")
  $
]

#example(title: "Exponential expectation")[
  Find the expected value of an exponential RV, with p.d.f.

  $
    f_X (x) = cases(lambda e^(-lambda x)", " &x > 0, 0"," &"elsewhere")
  $

  $
    E[x] = integral_(-infinity)^infinity x dot f(x) dif x = integral_0^infinity x dot lambda e^(-lambda x) dif x \
    = lambda dot integral_0^infinity x dot e^(-lambda x) dif x \
    = lambda dot [lr(-x 1 / lambda e^(-lambda x) |)_(x=0)^(x=infinity) - integral_0^infinity -1 / lambda e^(-lambda x) dif x] \
    = 1 / lambda
  $
]

#example(title: "Uniform dartboard")[
  Our dartboard is a disk of radius $r_0$ and the dart lands uniformly at
  random on the disk when thrown. Let $R$ be the distance of the dart from the
  center of the disk. Find $E[R]$ given density function

  $
    f_R (t) = cases((2t) / (r_0^2)", " &0 <= t <= r_0, 0", " &t < 0 "or" t > r_0)
  $

  $
    E[R] = integral_(-infinity)^infinity t f_R (t) dif t \
    = integral^(r_0)_0 t dot (2t) / (r_0^2) dif t \
    = 2 / 3 r_0
  $
]

=== Expectation of derived values

If we can find the expected value of $X$, can we find the expected value of
$X^2$? More precisely, can we find $E[X^2]$?

If the distribution is easy to see, then this is trivial. Otherwise we have the
following useful property:

$
  E[X^2] = integral_("all" x) x^2 f_X (x) dif x
$

(for continuous RVs).

And in the discrete case,

$
  E[X^2] = sum_("all" x) x^2 p_X (x)
$

In fact $E[X^2]$ is so important that we call it the *mean square*.

#fact[
  More generally, a real valued function $g(X)$ defined on the range of $X$ is
  itself a random variable (with its own distribution).
]

We can find expected value of $g(X)$ by

$
  E[g(x)] = integral_(-infinity)^infinity g(x) f(x) dif x
$

or

$
  E[g(x)] = sum_("all" x) g(x) f(x)
$

#example[
  You roll a fair die to determine the winnings (or losses) $W$ of a player as
  follows:

  $
    W = cases(-1", if the roll is 1, 2, or 3", 1", if the roll is a 4", 3", if the roll is 5 or 6")
  $

  What is the expected winnings/losses for the player during 1 roll of the die?

  Let $X$ denote the outcome of the roll of the die. Then we can define our
  random variable as $W = g(X)$ where the function $g$ is defined by $g(1) =
  g(2) = g(3) = -1$ and so on.

  Note that $P(W = -1) = P(X = 1 union X = 2 union X = 3) = 1 / 2$. Likewise $P(W=1)
  = P(X=4) = 1 / 6$, and $P(W=3) = P(X=5 union X=6) = 1 / 3$.

  Then
  $
    E[g(X)] = E[W] = (-1) dot P(W=-1) + (1) dot P(W=1) + (3) dot P(W=3) \
    = -1 / 2 + 1 / 6 + 1 = 2 / 3
  $
]

#example[
  A stick of length $l$ is broken at a uniformly chosen random location. What is
  the expected length of the longer piece?

  Idea: if you break it before the halfway point, then the longer piece has length
  given by $l - x$. If you break it after the halfway point, the longer piece
  has length $x$.

  Let the interval $[0,l]$ represent the stick and let $X ~ "Unif"[0,l]$ be the
  location where the stick is broken. Then $X$ has density $f(x) = 1 / l$ on
  $[0,l]$ and 0 elsewhere.

  Let $g(x)$ be the length of the longer piece when the stick is broken at $x$,

  $
    g(x) = cases(1-x", " &0 <= x < l / 2, x", " &1 / 2 <= x <= l)
  $

  Then
  $
    E[g(X)] = integral_(-infinity)^infinity g(x) f(x) dif x = integral_0^(l / 2) (l-x) / l dif x + integral_(l / 2)^l x / l dif x \
    = 3 / 4 l
  $

  So we expect the longer piece to be $3 / 4$ of the total length, which is a bit
  pathological.
]

=== Moments of a random variable

We continue discussing expectation but we introduce new terminology.

#fact[
  The $n^"th"$ moment (or $n^"th"$ raw moment) of a discrete random variable $X$
  with p.m.f. $p_X (x)$ is the expectation

  $
    E[X^n] = sum_k k^n p_X (k) = mu_n
  $

  If $X$ is continuous, then we have analogously

  $
    E[X^n] = integral_(-infinity)^infinity x^n f_X (x) = mu_n
  $
]

The *deviation* is given by $sigma$ and the *variance* is given by $sigma^2$ and

$
  sigma^2 = mu_2 - (mu_1)^2
$

$mu_3$ is used to measure "skewness" / asymmetry of a distribution. For
example, the normal distribution is very symmetric.

$mu_4$ is used to measure kurtosis/peakedness of a distribution.

=== Central moments

Previously we discussed "raw moments." Be careful not to confuse them with
_central moments_.

#fact[
  The $n^"th"$ central moment of a discrete random variable $X$ with p.m.f. $p_X
  (x)$ is the expected value of the difference about the mean raised to the
  $n^"th"$ power

  $
    E[(X-mu)^n] = sum_k (k - mu)^n p_X (k) = mu'_n
  $

  And of course in the continuous case,

  $
    E[(X-mu)^n] = integral_(-infinity)^infinity (x - mu)^n f_X (x) = mu'_n
  $
]

In particular,

$
  mu'_1 = E[(X-mu)^1] = integral_(-infinity)^infinity (x-mu)^1 f_X (x) dif x \
  = integral_(infinity)^infinity x f_X (x) dif x = integral_(-infinity)^infinity mu f_X (x) dif x = mu - mu dot 1 = 0 \
  mu'_2 = E[(X-mu)^2] = sigma^2_X = "Var"(X)
$

#example[
  Let $Y$ be a uniformly chosen integer from ${0,1,2,...,m}$. Find the first and
  second moment of $Y$.

  The p.m.f. of $Y$ is $p_Y (k) = 1 / (m+1)$ for $k in [0,m]$. Thus,

  $
    E[Y] = sum_(k=0)^m k 1 / (m+1) = 1 / (m+1) sum_(k=0)^m k \
    = m / 2
  $

  Then,

  $
    E[Y^2] = sum_(k=0)^m k^2 1 / (m+1) = 1 / (m+1) = (m(2m+1)) / 6
  $
]

#example[
  Let $c > 0$ and let $U$ be a uniform random variable on the interval $[0,c]$.
  Find the $n^"th"$ moment for $U$ for all positive integers $n$.

  The density function of $U$ is

  $
    f(x) = cases(1 / c", if" &x in [0,c], 0", " &"otherwise")
  $

  Therefore the $n^"th"$ moment of $U$ is,

  $
    E[U^n] = integral_(-infinity)^infinity x^n f(x) dif x
  $
]

#example[
  Suppose the random variable $X ~ "Exp"(lambda)$. Find the second moment of $X$.

  $
    E[X^2] = integral_0^infinity x^2 lambda e^(-lambda x) dif x \
    = 1 / (lambda^2) integral_0^infinity u^2 e^(-u) dif u \
    = 1 / (lambda^2) Gamma(2 + 1) = 2! / lambda^2
  $
]

#fact[
  In general, to find teh $n^"th"$ moment of $X ~ "Exp"(lambda)$,
  $
    E[X^n] = integral^infinity_0 x^n lambda e^(-lambda x) dif x = n! / lambda^n
  $
]

=== Median and quartiles

When a random variable has rare (abnormal) values, its expectation may be a bad
indicator of where the center of the distribution lies.

#definition[
  The *median* of a random variable $X$ is any real value $m$ that satisfies

  $
    P(X >= m) >= 1 / 2 "and" P(X <= m) >= 1 / 2
  $

  With half the probability on both ${X <= m}$ and ${X >= m}$, the median is
  representative of the midpoint of the distribution. We say that the median is
  more _robust_ because it is less affected by outliers. It is not necessarily
  unique.
]

#example[
  Let $X$ be discretely uniformly distributed in the set ${-100, 1, 2, ,3, ..., 9}$ so $X$ has probability mass function
  $
    p_X (-100) = p_X (1) = dots.c = p_X (9)
  $

  Find the expected value and median of $X$.

  $
    E[X] = (-100) dot 1 / 10 + (1) dot 1 / 10 + dots.c + (9) dot 1 / 10 = -5.5
  $

  While the median is any number $m in [4,5]$.

  The median reflects the fact that 90% of the values and probability is in the
  range $1,2,...,9$ while the mean is heavily influenced by the $-100$ value.
]
