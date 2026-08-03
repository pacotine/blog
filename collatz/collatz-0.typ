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

As you have seen from several examples, it seems that Hypothesis 1 in @collatz-421, where any starting number converges to the $4-2-1$ cycle, is the best one. In 1937, Lothar Collatz was the first to notice this strange property and many mathematicians quickly began to conjecture that every sequence converges to this $4-2-1$ cycle, regardless of the positive starting number. The *Collatz conjecture* was born. As I write this blog post, the problem remains unsolved, and no one has yet succeeded in proving that the conjecture is true.

= So, how could we solve this problem?
The good thing about conjectures is that there are only two possible outcomes: either it turns out to be true, or it is false. To refute a conjecture like this would mean finding a counterexample. Indeed, all it takes is a single number that does not satisfy the conjectured statement, and the conjecture would be refuted. Such a number would diverge (as in @collatz-diverge) or result in a cycle other than $4-2-1$ (as in @collatz-other-cycle).

== How can we find this counterexample?
Unfortunately, there is no known effective method other than testing all numbers until one is found that does not follow the $4-2-1$ pattern. As you can imagine, mathematicians didn't give up, and they asked their computer science colleagues to write a program capable of testing the Collatz conjecture on a large number of inputs. To be exact, they checked up to $2^71$. Just think about how big that number is: it's a 2 followed by 21 zeros. And guess what? They all converged on the $4-2-1$ cycle.

Does this prove that the Collatz conjecture is true, since there doesn't seem to be any counterexample? Absolutely not. In mathematics, showing that something is true for "quite a few" cases is certainly not enough. Even if a vast number of integers converge to the $4-2-1$ cycle, this is far from covering all integers, and the proof still remains to be shown. Refuting a conjecture requires only a single counterexample, but proving it true requires a rigorous and general proof. That doesn't mean, however, that these results are useless. For example, it gives an idea of the order of magnitude of a cycle other than $4-2-1$. Indeed, if the cycle were small (as in the illustrative example in @collatz-other-cycle), then one of the tested numbers would have converged to that other cycle. Thus, so far, we know that if any repeating cycle other than the 3-step $4-2-1$  cycle exists, then it must contain at least 355,504,839,929 steps. It means that if there is a completely different cycle out there somewhere in the infinite universe of numbers that never touches the number 1, 4 or 2, then it cannot be a simple 3-step, 10-step, or even a million-step cycle.

That leaves the counterexamples that rely on divergence (see @collatz-diverge). Finding a sequence that will never converge to a cycle seems even less likely. One argument supporting this is linked to a probabilistic heuristic of average decay. I won't go into the details here, but the key point to remember is that the scientific community considers the existence of such a sequence to be extremely unlikely, although, once again, this does not constitute absolute proof of its nonexistence.

== In that case, how can we prove that the conjecture is true?


])