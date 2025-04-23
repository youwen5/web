#import "./lib/html-shim.typ": html-shim

#show: html-shim

= A test of Typst math rendering

Let $U$ and $V$ be $FF$-vector spaces. Suppose that $U$ is finite-dimensional of dimension $n >= 1$. Let $S = {u_1,...,u_n}$ be a basis for $U$. Given any map $f : S -> V$ (of sets), show that there is a unique linear map
$
  tau_f : U -> V
$
such that $tau_f (u_i) = f(u_i)$ for all $i = 1,...,n$.

Let $f : S -> V$ is a map. Let $tau_f$ be a linear map that satisfies $tau_f
(u_i) = f(u_i)$. Let $x$ be any vector in $U$. Because $S$ is a basis, $exists lambda_1,...,lambda_n$ s.t. $x = lambda_1 u_1 + dots.c + lambda_n u_n$. By linearity, $tau_f (x) = lambda_1 tau_f (u_1) + dots.c + lambda_n tau_f (u_n) = lambda_1 f(u_1) + dots.c + lambda_n f(u_n)$.

Suppose there was another linear map, $tau'_f$, where
$tau'_f (u_i) = f(u_i)$ for all $i = 1,...,n$. Because $S$ is a basis, the representation $x = lambda_1 u_1 + dots.c + lambda_n u_n$ is unique, so $tau'_f (x) = lambda_1 tau'_f (u_1) + dots.c + lambda_n tau'_f (u_n) = lambda_1 f(u_1) + dots.c + lambda_n f(u_n)$. So $forall x in U$, $tau_f (x) = tau'_f (x)$ and $tau_f = tau'_f$.
