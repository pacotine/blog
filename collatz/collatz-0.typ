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

Does this prove that the Collatz conjecture is true, since there doesn't seem to be any counterexample? Absolutely not. In mathematics, showing that something is true for "quite a few" cases is certainly not enough. Even if a vast number of integers converge to the $4-2-1$ cycle, this is far from covering all integers, and the proof still remains to be shown. Refuting a conjecture requires only a single counterexample, but proving it true requires a rigorous and general proof. That doesn't mean, however, that these results are useless. For example, it gives an idea of the order of magnitude of a cycle other than $4-2-1$. Indeed, if the cycle were small (as in the illustrative example in @collatz-other-cycle), then one of the tested numbers would have converged to that other cycle. Thus, so far, researchers have shown that if any repeating cycle other than the 3-step $4-2-1$ cycle exists, then it must contain at least 355,504,839,929 steps#footnote[In 2025, #link("https://link.springer.com/content/pdf/10.1007/s11227-025-07337-0.pdf")[a project to verify the conjecture] confirmed convergence for all integers up to $2048 times 2^60$ and found out this number, which represents the absolute minimum number of steps a hypothetical nontrivial loop (a loop other than $4-2-1$) must have in the Collatz sequence. In 1993, mathematician Shalom Eliahou determined under which size constraint $p$ a nontrivial cycle must exist: $p=301994a+17087915b+85137581c$ for some $a >= 0, b >= 1, c >= 0$ with $a c = 0$. These recent computer-based verifications that yielded the minimum value for a nontrivial cycle constrain the constants $a$, $b$, and $c$ to certain minimum values, thus yielding this size $p = 355504839929$ of a nontrivial cycle.]. It means that if there is a completely different cycle out there somewhere in the infinite universe of numbers that never touches the number 1, 4 or 2, then it cannot be a simple 3-step, 10-step, or even a million-step cycle.

That leaves the counterexamples that rely on divergence (see @collatz-diverge). Finding a sequence that will never converge to a cycle seems even less likely. One argument supporting this is linked to a probabilistic heuristic of average decay. I will go into the details in @true, but the key point to remember is that the scientific community considers the existence of such a sequence to be extremely unlikely, although, once again, this does not constitute absolute proof of its nonexistence.

== In that case, how can we prove that the conjecture is true?<true>
Indeed, if the experimental evidence seems to suggest that no counterexamples exist, then the conjecture is _surely_ true. Moving from a conjecture to a theorem, however, is somewhat more complex. A formal and rigorous proof would be needed to show that, for every natural number, its Collatz sequence converges to the $4-2-1$ cycle. At present, there is no such proof, nor is there even an obvious approach to a complete and universal proof. However, mathematicians have developed various theoretical approaches that allow them to argue for the truth of the conjecture. Although these models do not lead to a definitive conclusion, they strengthen confidence in the proof of the conjecture.

The most fruitful approach was led by the renowned mathematician Terence Tao. It involves a probabilistic and statistical analysis of the problem.\
Even if we cannot prove that all Collatz sequences converge, it is possible to prove that *almost all* of them converge. We must be careful with the term "almost all", because in mathematics it does not have the expected meaning of "most of them". This term has a strict technical definition, such as "all of them in the limit", even if an infinite number of exceptions may exist. In this context, when a mathematician says that a property holds for _almost all_ integers, they mean that if we consider the set of numbers from $1$ to $N$, the percentage of numbers that satisfy this property approaches 100% as $N$ tends to infinity. So what Terence Tao proved in 2019, using methods from partial differential equations, was that if you pick a random integer, the probability that its Collatz sequence fails to drop down to a very small value is exactly 0% in the limit, that is, _almost all_#footnote[In the sense of logarithmic density.] Collatz sequences converge.

That's all well and good, but it's hard to understand why these results are so obvious. So I'm going to give you another argument based on probabilistic heuristics.\
Remember the steps for constructing a Collatz sequence starting from a natural number $n$: divide by 2 if $n$ is even ($n/2$), multiply by 3 and add 1 if $n$ is odd ($3n+1$). Perhaps you've noticed that it's possible to simplify one of these steps. Indeed, when $n$ is odd, multiplying by 3 and adding 1 will always result in an even number#footnote[3 is odd, so multiplying it by an odd number will yield another odd number. Adding 1 yields an even number.]. So whenever $n$ is odd, we can directly perform the operation $(3n+1)/2$, that is, multiply by 3, add 1, and divide by 2. With this rewriting of the problem, we can track the jumps from one odd number to another odd number. Using a little probability theory and statistics, we can show that then each odd number is on average $3/4$ the previous one (75%). This means that, on average, numbers tend to decrease in the long run, and the sequence divergence becomes statistically unlikely. Once again, this is obviously not a valid proof because it treats Collatz sequences using a probabilistic heuristic, whereas each numbers in a sequence depends heavily on their algebraic properties and previous values, which are not random at all. However, it provides yet another piece of evidence supporting the validity of the conjecture.

There are other approaches and arguments, particularly those that use modular arithmetic, rational approximations (to show that no other repeating cycles exist outside the known $4-2-1$), inverse trees and algebraic mapping (to demonstrate structural reachability for all integers by constructing backward-branching tree structures from 1 to map paths), etc. But Terence Tao's statistical approach remains, to this day, the greatest breakthrough in this problem. It is, in fact, considered to be "one of the most significant results on the Collatz conjecture in decades"#footnote[If you're interested, this quote comes from the journal Quanta Magazine, which #link("https://www.quantamagazine.org/mathematician-proves-huge-result-on-dangerous-problem-20191211/")[published an article] on its progress on the problem.].

= So what now?
To date, this problem remains unsolved. Because of the simplicity of its state, it is often tackled by amateurs who believe they have solved it and publish results that fall far short of what experts in the field expect; the experts, for their part, believe they will never see such a problem solved in their lifetime. Recently, the LLM systems developed by major startups have improved in conjecture-solving, and despite impressive results for many problems, the Collatz conjecture has yet to be shaken by this technology. As an aside, the conjecture was considered solved for a few days because a proof assistant system#footnote[A tool used by mathematicians to verify, step by step, whether a proof is valid. Evidence provided by a proof assistant is often considered more reliable than the ones verified by an expert. The most well-known proof assistant is Lean.] had a flaw that the authors exploited to disprove the Collatz conjecture. I hope that after reading my short blog post on the subject, you are surprised by this result. Rest assured, the bug has been fixed, and the conjecture remains unproven to this day...

#quote(block:true, attribution: [Shizuo Kakutani, Japanese-American mathematician who introduced the problem at so many universities that it is sometimes called the Kakutani's problem])["For about a month everyone at Yale worked on it, with no result. A similar phenomenon happened when I mentioned it at the University of Chicago. A joke was made that this problem was part of a conspiracy to slow down mathematical research in the U.S [during Cold War]."]

])