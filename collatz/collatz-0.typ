#import "/template.typ": *
#import "@preview/lilaq:0.6.0" as lq

#let collatz(n) = {
    let seq = (n,)
    while n > 4 {
        if calc.rem(n, 2) == 0 {
            n = n/2
        }
        else {
            n = 3*n+1
        }
        seq.push(n)
    }

    return seq
}

#show: content => post("collatz", 0,
[
"Mathematics may not be ready for such problems" said Paul Erdős, one of the greatest mathematicians of the 20th century. However, I assure you that this problem, or at least its description, could be understood by a child as young as 10. Do you think I'm exaggerating? A 10-year-old has no background in math, aside from addition, multiplication, and a basic grasp of division; you might say. Yet that's all you need to understand this problem. It is by far the simplest to explain, visualize, and understand; just as it is surely by far the most complex to solve. Do you know how to divide a number by 2 or multiply it by 3? Then you're ready to discover one of the most famous problems in mathematics, one that has baffled even the greatest geniuses on the planet as they've tried to solve it: the *Collatz conjecture*.

= What is this problem with its paradoxical difficulty?
Pick an number, any positive integer you like.

+ If it is even, divide it by 2;
+ If it is odd, multiply it by 3 and add 1;
+ Go back to step one with the number you obtained.

Here is the statement of the problem. That's all. You see, I didn't lie.

Now let me walk you through an example. I'm going to choose the number 42. 42 is even, so I divide it by 2 and get 21. 21 is odd, so I multiply it by 3 and add 1, and get 64. 64 is even, so I divide it by 2 and get 32, which is also even. This leads me to 16, 8, and 4. 4 is even, so I divide it by 2 and get 2. 2 is even, so I divide it by 2 and get 1. 1 is odd, so I multiply it by 2 and add 1, which gives me 4... which I've already obtained. If I continue, I get 2, then 1, then 4, then 2, then 1, then 4, and so on.

#let y = (42, 21, 64, 32, 16, 8, 4)
#let x = range(1, y.len(), inclusive: true)

#let yb = (4, 2, 1, 4, 2, 1, 4, 2, 1)
#let xb = range(y.len(), y.len()+yb.len()-1, inclusive: true)

#show: lq.set-legend(position: right+top, fill: black)
#set text(fill: white)
#figure(caption: [Collatz sequence for $n = 42$.])[#lq.diagram(
  width: 600pt,
  height: 200pt,
  xlabel: [Step], 
  ylabel: [Value],
  lq.plot(x, y, mark:"d", stroke: yellow+2pt, label: [Collatz sequence for $n = 42$]),
  lq.plot(xb, yb, mark:"d", stroke: red+2pt, label: [$4-2-1$ cycle])
)]<collatz-42>

Note the $4-2-1$ cycle, shown in red in @collatz-42. Landing on 4, 2, or 1 traps us in a loop: the $4-2-1$ cycle. You have no doubt encountered the same cycle with your own number. Perhaps it's because we chose small numbers? So let's try with 275,828,492 (see @collatz-big).

#let y = collatz(275828492)
#let x = range(1, y.len(), inclusive: true)

#let yb = (4, 2, 1, 4, 2, 1, 4, 2, 1)
#let xb = range(y.len(), y.len()+yb.len()-1, inclusive: true)

#figure(caption: [Collatz sequence for $n = 275828492$.])[#lq.diagram(
  width: 600pt,
  height: 600pt,
  xlabel: [Step], 
  ylabel: [Value],
  lq.plot(x, y, mark:"d", stroke: yellow+2pt, label: [Collatz sequence for $n = 275828492$]),
  lq.plot(xb, yb, mark:"d", stroke: red+2pt, label: [$4-2-1$ cycle]),
  lq.rect(110, -5000000, height: 0.1*calc.pow(10, 8), width: 28, stroke: white),
  lq.place(65%, 72%, align: center, lq.diagram(
    fill: black,
    xaxis: (stroke: white+1pt, subticks: none),
    yaxis: (stroke: white+1pt, subticks: none),
    ylim: (-1, 100),
    width: 300pt,
    height: 200pt,
    margin: 0%,
    lq.plot(range(110, 128), collatz(y.at(110)), mark:"d", stroke: yellow+2pt),
    lq.plot(range(127, 127+9), yb, mark:"d", stroke: red+2pt)
  ))
)]<collatz-big>

Once again, we get this $4-2-1$ cycle shown in red!

== So what's the deal?
If you try this with other numbers (both small and very large), you'll find that every single time, without exception, you end up back in this $4-2-1$ cycle. It seems that, no matter what the starting number is, our yellow trajectory shown in @collatz-42 and @collatz-big inevitably ends up falling back into this cycle. That is the Collatz conjecture#footnote[To be more precise, the conjecture states that any starting number yields a sequence that converges to 1, but you will readily agree that falling into the $4-2-1$ cycle is equivalent to converging to 1.].

There are only three possible solutions to this problem: 
- any chosen starting number does indeed fall into this $4-2-1$ cycle (@collatz-421);
- there exists a starting number that yields a sequence falling into a cycle _other than_ $4-2-1$, a cycle that may be larger or have numbers much further apart (@collatz-other-cycle);
- there exists a starting number that yields a sequence that shoots off without ever coming back down, and the sequence is said to _diverge_ (@collatz-diverge).

#let y = (42, 21, 64, 32, 16, 8, 4)
#let x = range(1, y.len(), inclusive: true)

#let yb = (4, 2, 1, 4, 2, 1, 4, 2, 1)
#let xb = range(y.len(), y.len()+yb.len()-1, inclusive: true)
#figure(caption: [Hypothesis 1: every Collatz sequence converges to the $4-2-1$ cycle.])[#lq.diagram(
  width: 600pt,
  height: 200pt,
  xlabel: [Step], 
  ylabel: [Value],
  lq.plot(x, y, mark:"d", stroke: yellow+2pt, label: [Collatz sequence for $n = 42$]),
  lq.plot(xb, yb, mark:"d", stroke: red+2pt, label: [$4-2-1$ cycle])
)]<collatz-421>

#let x = range(1, 9)
#let y = collatz(23).slice(0, 7)
#y.push(100)

#let xb = range(8, 20)
#let yb = (100, 42, 23, 33, 100, 42, 23, 33, 100, 42, 23, 33)

#figure(caption: [Hypothesis 2: there exists a sequence that converges to a cycle other than $4-2-1$ (this is an illustrative plot; the values are arbitrary).])[#lq.diagram(
  width: 600pt,
  height: 200pt,
  margin: 0%,
  xlabel: [Step], 
  ylabel: [Value],
  ylim: (-1, 162),
  lq.plot(x, y, mark:"d", stroke: yellow+2pt, label: [Collatz sequence for a special number]),
  lq.plot(xb, yb, mark:"d", stroke: purple+2pt, label: [$100-42-23-33$ cycle])
)]<collatz-other-cycle>

#let y = collatz(27)
#let x = range(1, y.len(), inclusive: true)

#show: lq.set-legend(position: left+top, fill: black)
#figure(caption: [Hypothesis 3: there is a sequence that never ends, that is, it has no cycle and diverges.])[#lq.diagram(
  width: 600pt,
  height: 200pt,
  xlabel: [Step], 
  ylabel: [Value],
  xlim: (1, 78),
  lq.plot(x, y, mark:"d", stroke: yellow+2pt, label: [Collatz sequence for a special number])
)]<collatz-diverge>

])