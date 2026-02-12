---
title: "The Eckmann-Hilton Argument"
published: 2026-02-13
---

#import "@preview/html-shim:0.1.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#show: html-shim

#let proof(body, name: none) = {
  [_Proof_]
  if name != none {
    [ #thmname[#name]]
  }
  [.]
  body

  // Add a word-joiner so that the proof square and the last word before the
  // 1fr spacing are kept together.
  sym.wj

  // Add a non-breaking space to ensure a minimum amount of space between the
  // text and the proof square.
  sym.space.nobreak
  tombstone
}

#set text(lang: "zh")

#let theorem(body) = callout("Theorem", body)

Eckmann-Hilton 论证使得许多看似更复杂的结构坍缩为更简单的结构。例如，任意拓扑空间的基本群总是阿贝尔群。

#theorem[
  设 $S$ 为一个集合，且在两个含幺二元运算 $plus.o$ 和 $times.o$ 下构成原群。假设其中一个运算是另一个运算的同态，则 $plus.o = times.o$，且 $S$ 在这些运算下构成交换幺半群。
]

我们通常将同态描述为与某种结构相容的一元函数，例如 $f : S -> S$ 满足 $f(x plus.o y) = f(x) plus.o f(y)$。二元同态则形如：
$ (a times.o b) plus.o (c times.o d) = (a plus.o c) times.o (b plus.o d). $
$b$ 和 $c$ 的位置"交换"看似奇怪，但这正是同态作为相容运算这一概念的二元类比：$a$ 乘 $b$ 加 $c$ 乘 $d$ 等同于先将 $a$ 加 $c$ 再乘以 $b$ 加 $d$。

#btw[
  具有含幺二元运算的集合称为_含幺原群_。含幺意味着该运算具有唯一的左单位元和右单位元，且一个简单的论证即可表明这两个单位元实际上是相同的。
]

#proof[
  关键步骤是证明两个运算的单位元相同。设 $bb(1)_plus.o$ 和 $bb(1)_times.o$ 分别为 $plus.o$ 和 $times.o$ 的单位元，则
  $
    (bb(1)_times.o plus.o bb(1)_plus.o) times.o (bb(1)_plus.o plus.o bb(1)_times.o) = bb(1)_times.o = (bb(1)_times.o times.o bb(1)_plus.o) plus.o (bb(1)_plus.o times.o bb(1)_times.o) = bb(1)_plus.o.
  $

  证明的其余部分应当容易得出。通过构造
  $
    forall a, b in S, (a plus.o bb(1)) times.o (bb(1) plus.o b)
  $
  可得 $plus.o = times.o$，类似的论证可得结合律和交换律，从而证明 $S$ 在这些运算下确实构成交换幺半群，证毕。
]

Eckmann-Hilton 的另一个推论是：幺半群范畴 *Mon* 中的幺半群对象是交换幺半群。事实上，这可以作为该论证本身的范畴论表述。
