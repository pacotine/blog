#import "template.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import fletcher.shapes: ellipse, octagon
#import "@preview/lilaq:0.6.0" as lq

#show: content => post("p-np",
[

In 2000, the #link("https://www.claymath.org/millennium-problems/")[Clay Mathematics Institute] selected seven open problems and offered a \$1 million reward to anyone who could provide a correct solution to one of them. Among these problems of paramount importance in science, known as the *Millennium Problems*, one stands out for its complexity, its apparent simplicity given the statement of the problem, and its potential impact if it were to be solved. Today I'd like to introduce you to the most iconic open problem in mathematics and computer science: the *P vs. NP* problem. How do we define what is effective and what is not? How do we solve a problem effectively? Does a problem that is simple to solve always have a solution that is simple to verify? What if the opposite were true? Are you ready to delve into the fascinating world of complexity theory through what is surely the most important mathematical problem of the millennium? Just a friendly reminder: don't worry, this is a #colored(level-zero.lighten(50%))[Level-0 post], so I'll try to use as little math as possible, even though that will be a challenge here.

Let's get _rich_!

= What is a problem? <problem>
In *theoretical computer science*, a problem is defined as anything that can be solved by what is called an *algorithm*, specified by an input and a desired output. An algorithm, a finite sequence of (mathematically rigorous) instructions, can be thought of as a recipe, where the ingredients are the inputs and the desired outcome of the recipe is the output. There are different types of problems: for example, we distinguish between those that are posed as yes/no questions (*decision problems*) and those in which we seek a valid solution for a given input (*search problems*). A simple example of a problem is finding the minimum in a list of numbers (the algorithm that solves this involves traversing the entire list and updating the minimum each time a new one is found). Another problem, a more difficult one this time, is solving a Sudoku puzzle. In fact, as long as there is a way to formulate a problem in a mathematically abstract way, we can then investigate whether there is an algorithm capable of solving it.

The work of a researcher in *computational complexity theory*#footnote[A field of research at the intersection of mathematics and theoretical computer science.] is to "zoologize" these problems, that is, to classify them according to a criterion known as their *complexity*#footnote[To be more precise, complexity is a metric for algorithms that solve problems, and so when we talk about the _complexity of a problem_, we are referring to the complexity of the best-known algorithm that solves it.].

== When you say _complexity_, do you mean how difficult the problem is? <complexity>
Not really. What really interests researchers in this field isn't how difficult a problem is to understand or solve (in the sense that the algorithm is lengthy or difficult to grasp), but rather how much resources (_time_ and _space_) it uses.

But how do we measure the time it takes for an algorithm to run? You'll agree with me that if you used a stopwatch to time an algorithm running on your laptop, the result would be very different from running the same algorithm on NASA's supercomputers. Indeed, it seems pointless to measure an algorithm's execution time in seconds. Instead, we prefer to count the number of basic instructions (or _elementary operations_) used during its execution. Let me explain with an example.

#set text(fill: white)
#figure(html.frame(diagram(
  edge-stroke: white,
  cell-size: (4em, 1em),
  node((1, 0), [#emoji.airplane]),
  node((2, 0), [#emoji.apple]),
  node((3, 0), [#emoji.rocket]),
  node((4, 0), [#emoji.worm]),
  node((5, 0), [#emoji.planet]),
  edge((4, 1), (4, 0), "-|>"),
  node((4, 1), [smallest element]),
  edge((0, 1.5), (5, 1.5)),
  node((0, 2), [candidate:]),
  node((1, 2), [#emoji.airplane]),
  node((2, 2), [#emoji.apple]),
  node((3, 2), [#emoji.apple]),
  node((4, 2), [#emoji.worm]),
  node((5, 2), [#emoji.worm]),
  edge((5, 2), (5, 3), "-|>"),
  node((5, 3), [output])
)),
caption: [An algorithm for finding the smallest element in a list of objects.]
)<algo-min>

The algorithm described in @algo-min compares each element with the candidate and updates the candidate whenever a new smaller object is found. Here there are 5 objects, and it took the algorithm 5 comparisons to find the result. This number of comparisons is our elementary operation in this algorithm. It allows us to measure the _complexity_ of the algorithm independently of the machine (and the microprocessor's speed in seconds). For 5 objects, 5 elementary operations; for 10 objects, 10 elementary operations; for 100 objects, 100 operations; for 1,000, 1,000... you get the idea. In this case, we say that the complexity is _linear_, because if we plot a curve showing the number of instructions as a function of the number of objects, we get a straight line.

Okay, now let's imagine we're using the algorithm shown in @algo-min to sort these 5 objects from smallest to largest. All we have to do is find the smallest element, remove it from the list, and repeat the process until they're all sorted. Thus, by repeating this algorithm of 5 instructions 5 times, we get a sorting algorithm. For 10 objects, we will have to repeat the minimum-search algorithm 10 times; for 100 objects, we will have to repeat it 100 times; for 1,000... in short, for $n$ objects, we will need to perform approximately $n^2$ elementary operations. For this reason, the complexity of this algorithm is said to be _quadratic_. @lin-quad illustrates just how noticeable the difference in complexity becomes as $n$ (the number of objects in our case) approaches infinity. A quadratic algorithm is therefore, in a sense, _worse_ than a linear algorithm, regardless of the machine you use.

#let x = lq.linspace(1, 1000)
#show: lq.set-legend(position: left+top, fill: black)
#figure(lq.diagram(
  width: 600pt,
  height: 200pt,
  xscale: "log",
  xlabel: [Number of objects], 
  ylabel: [Number of elementary operations],
  lq.plot(x, x => x, label: [Linear $f(n) = n$]),
  lq.plot(x, x => x*x, label: [Quadratric $f(n) = n^2$])
), caption: [Linear complexity vs. quadratic complexity (logarithmic scale).])<lin-quad>

Linear and quadratic algorithms are considered the most useful in practice, as they allow any computer to process a very large number of input elements without too much difficulty. Conversely, some algorithms have what is known as _exponential_ complexity, meaning that the number of elementary operations grows exponentially with the number of input elements. These kinds of algorithms are terrible in practice because even a hundred input objects will give the world's best computers a hard time#footnote[For an algorithm with a complexity of the order of $2^n$, after 200 objects, we are already in the same order of magnitude as the estimated number of atoms in the observable universe.], and with each additional object, the complexity will only increase drastically.

Note also that measuring complexity is more complex in practice; notably, there are three ways to measure it: worst-case, average, and best-case. Another potentially interesting fact: it has been proven that the best sorting algorithm (as described above) cannot be linear#footnote[Which makes intuitive sense: how, for example, could you sort a deck of cards by looking at each card only once? If a linear comparison sort existed, it would mean that you could sort this deck of cards in a single pass without moving any card more than once.], and to date, the best sorting algorithms that use comparisons (as shown in @algo-min) are not quadratic, but linear-logarithmic (that is, of the form $n log(n)$ and thus more efficient than our naive quadratic comparison sort).

== So how do we categorize these problems?
Linear ($n$), quadratic ($n^2$), cubic ($n^3$), in short, any algorithm whose complexity can be expressed as a polynomial ($n$ raised to any power, for example $n^42$) is classified in what is called the *P class*. #smallcaps[P] stands for #smallcaps[PTIME] or _polynomial_: if there exists an algorithm of polynomial complexity for a given decision problem (see @problem for the definition), then that problem belongs to class #smallcaps[P]. If the best-known algorithm for a problem is exponential (e.g. $2^n$) therefore this problem does _not_ belong to #smallcaps[P]. On the other hand, our algorithms for finding the smallest object and for sorting, described in @algo-min, are two algorithms that solve problems that belong to #smallcaps[P].

== Oh, so #smallcaps[NP] stands for Non-Polynomial?
No! That's what I sometimes hear from people who aren't familiar with the subject. #smallcaps[NP] stands for _non-deterministic polynomial_ (I agree, they could have chosen a better abbreviation). Don't try to figure out why it's called like that; just see how this class is subtly different from #smallcaps[P]. The *#smallcaps[NP] class* includes all problems that are _verifiable_ in polynomial time. "Verifiable" is an important word here: a decision problem belongs to the #smallcaps[NP] class if its solution can be _verified_ in polynomial time.

For example, imagine that you are solving the problem "Can the objects be sorted from smallest to largest" shown in @algo-min, that is, you are sorting the 5 objects using the algorithm described above. Then verifying the solution to this problem is the same as solving "Are the objects correctly sorted from smallest to largest?", which is indeed a decision problem, and it can be solved in polynomial time (you simply need to examine each element from left to right, stopping when an object is smaller than the previous one): the sorting problem is therefore in #smallcaps[NP]. You'll notice that sorting objects and verifying the solution are both problems solvable in polynomial time; therefore, sorting objects is a problem that belongs to both #smallcaps[P] and #smallcaps[NP]. In fact, the entire class #smallcaps[P] is contained within the class #smallcaps[NP]. Indeed, if it is "simple" to solve a problem, then it is "simple" to verify its solution. This is a long-known result: $"P" subset "NP"$ (#smallcaps[P] is contained in #smallcaps[NP]).

The \$1 million Millennium Prize Problem, thus, seeks to determine whether this is a strict inclusion ($"P" subset.neq "NP"$ or $"NP" subset.not "P"$ which, mathematically, would imply that $"P" != "NP"$) or whether #smallcaps[NP] is also included in #smallcaps[P] (which, mathematically, would imply that $"P" = "NP"$). @p-not-np and @p-is-np visually illustrate the difference in the relationship between the classes depending on whether #smallcaps[P] $=$ #smallcaps[NP] or not.

#figure(html.frame(diagram(
  node(align(top)[#text(fill: red)[P]], stroke: red, enclose: ((1, 2), (3, 1), <p-text>), shape: ellipse, fill: purple.transparentize(50%), layer: 1, outset: 1.5em, name: <p>),
  node(align(bottom)[#text(fill: aqua)[NP]], stroke: aqua, enclose: ((4, 0), (0, 4), <p>, <np-text>), shape: ellipse, fill: aqua.transparentize(50%), name:<np>),
  node(<p.center>, ["easy" to solve _and_ "easy" to verify], layer: 1, name:<p-text>),
  node(<p.south>, ["easy" to verify _but_\ not necessarily "easy" to solve], name:<np-text>)
)),
caption: [Euler diagram illustrating the relationship between P and NP if $"P" != "NP"$.]
)<p-not-np>

#figure(html.frame(diagram(
  node(align(top)[#text(fill: red)[P] $=$ #text(fill: aqua)[NP]], stroke: gradient.linear(aqua, purple, red), enclose: ((4, 0), (0, 4), <text>), shape: ellipse, fill: purple.transparentize(50%), name: <p>),
  node(<p.center>, ["easy" to solve _and_ "easy" to verify], name:<text>)
)),
caption: [Euler diagram illustrating the relationship between P and NP if $"P" = "NP"$.]
)<p-is-np>

To this day, certain problems are still considered to be in #smallcaps[NP], and no polynomial-time algorithm has been found to move them into #smallcaps[P] (see @p-not-np). This is the case, for example, with Sudoku: filling in a Sudoku grid is "hard"#footnote[Even for a computer, even though it's faster than you, from an algorithmic complexity standpoint, as discussed in @complexity, it remains a problem that is "not easy" to solve; and hence it does not belong to #smallcaps[P].], but verifying a solution, i.e. a filled-in grid, is very "easy" (it can be done in polynomial time, so it belongs to #smallcaps[NP])!

= But then, how can we prove that $"P" eq.quest "NP"$?
You only have two possible approaches: prove that #smallcaps[P] is different from #smallcaps[NP], or prove that #smallcaps[P] is indeed equal to #smallcaps[NP]. For the first case, you must prove that there exists an #smallcaps[NP] problem (one that can be verified in polynomial time) that _cannot_ be solved in polynomial time (and therefore does _not_ belong to #smallcaps[P]). A single problem is enough to prove that #smallcaps[P] is strictly contained in #smallcaps[NP] (see @p-not-np). In the second case, i.e. proving that #smallcaps[P] is indeed equal to #smallcaps[NP], it's more complicated. The most "straightforward" proof would be to show that all #smallcaps[NP] problems are also in #smallcaps[P]... and that's a task that would take you forever, since you can always come up with new problems. No, the brute-force method won't get us very far; we need to be smarter. Fortunately, experts in this field have found a trick to reduce the number of problems that need to be considered in a purported proof of $"P" = "NP"$: the #smallcaps[NP-complete] problems.

== NP-what?
There are #smallcaps[NP] problems that are so difficult that they become, in a sense, "universal". Universal such that any other #smallcaps[NP] problem can be reduced to this kind of very difficult problem. These problems are called *#smallcaps[NP-complete] problems*#footnote[The formal definition of an #smallcaps[NP-complete] problem is: $X$ is an #smallcaps[NP-complete] problem if $X$ is an #smallcaps[NP] problem _and_ that every #smallcaps[NP] problem is *reducible* (a mathematical term in complexity theory) to $X$ in polynomial time.]. You can think of them as problems that generalize all #smallcaps[NP] problems. I also like to think of them as the edges of the ellipses in Euler diagrams shown @p-not-np. There's nothing harder, nothing more "NP" than these #smallcaps[NP-complete] problems, and that's why I like this analogy.

Because of this property, if you can solve an #smallcaps[NP-complete] problem in polynomial time, then that is equivalent to solving all #smallcaps[NP] problems in polynomial time. Using my analogy with Euler diagrams, you can think of this as mapping the edges of the #smallcaps[NP] ellipse to the edges of the #smallcaps[P] ellipse. And yes, if you've been following along so far, then you understand that to prove that $"P" = "NP"$, it is "enough" to solve (find a polynomial-time algorithm for) a single problem: an #smallcaps[NP-complete] problem. Today, we know of more than 3,000 of them. But many are constructed from, or can be reduced to, the most abstract #smallcaps[NP-complete] problem known: the *#smallcaps[3-SAT] problem*.

== What is #smallcaps[3-SAT]?
This time, the name was chosen more appropriately: the term #smallcaps[SAT] comes from "satisfiability", and the number preceding it specifies the type of #smallcaps[SAT] problem based on the maximum number of variables (in this case, 3). All these words sound pretty complicated, so let me illustrate this problem with a little story (see @sat). Three astronauts, Alice, Bob, and Charlie, are preparing for a long-duration space mission. These three astronauts have items at their disposal that they may or may not take with them into space. NASA allows each of them to specify their own _requirements_ ("I want to take this item with me") and _vetoes_ ("I don't want this item to be taken on board"), but the total number (requirements $+$ vetoes) must not exceed 3, though they can specify fewer. The goal of the problem is as follows: NASA must guarantee each astronaut that at least one of their requests, a requirement or veto, will be satisfied (hence the name). Determining whether such a satisfiability solution exists is a #smallcaps[SAT] problem.

#figure(html.frame(diagram(
  node((0, 0), [Alice], fill: gray.transparentize(80%), name: <alice>),
  node((1, 0), [Bob], fill: gray.transparentize(80%), name: <bob>),
  node((2, 0), [Charlie], fill: gray.transparentize(80%), name: <charlie>),

  node((0, 1), [#emoji.cat #emoji.trumpet], fill: green.transparentize(60%), shape: octagon, name: <alice-req>),
  node((0, 2), [#emoji.saxophone], fill: red.transparentize(60%), shape: octagon, name: <alice-vet>),

  node((1, 1), [#emoji.banana], fill: green.transparentize(60%), shape: octagon, name: <bob-req>),
  node((1, 2), [#emoji.syringe #emoji.apple], fill: red.transparentize(60%), shape: octagon, name: <bob-vet>),

  node((2, 1), [#emoji.toothbrush #emoji.apple], fill: green.transparentize(60%), shape: octagon, name: <charlie-req>),
  node((2, 2), [#emoji.cat], fill: red.transparentize(60%), shape: octagon, name: <charlie-vet>),

  node(fill: aqua.transparentize(50%), enclose: (<alice>, <alice-req>, <alice-vet>), corner-radius: 1em),
  node(fill: aqua.transparentize(50%), enclose: (<bob>, <bob-req>, <bob-vet>), corner-radius: 1em),
  node(fill: aqua.transparentize(50%), enclose: (<charlie>, <charlie-req>, <charlie-vet>), corner-radius: 1em),

  node([List of Available Items\ #emoji.apple #emoji.avocado #emoji.basecap #emoji.stethoscope #emoji.cat #emoji.tv #emoji.banana #emoji.saxophone #emoji.trumpet #emoji.wrench #emoji.chocolate #emoji.toothbrush #emoji.syringe], fill: navy, enclose: ((0, 4), (1, 4), (2, 4)), corner-radius: 1em)

)),
caption: [The #smallcaps[3-SAT] problem illustrated by the story of the astronauts. Alice wants to bring her cat and her trumpet, but hates hearing Charlie play the saxophone; Bob absolutely wants to bring bananas for breakfast, but he hates apples and is afraid of syringes; Charlie absolutely wants apples for breakfast and his toothbrush, but he is allergic to cats. At least one of their respective constraints must be met by NASA for everyone to be satisfied.]
)<sat>

Since this problem is #smallcaps[NP-complete], it is by definition #smallcaps[NP], and therefore verifying a solution must be "simple". Indeed, in the example shown in @sat, if NASA provides the list of objects selected for the trip, verifying whether it satisfies each astronaut's constraints can be done in polynomial time. So the million-dollar question is: is this problem in P? Meaning, is it equally "easy" to solve? Or, in other words, is there a polynomial-time algorithm that solves this problem?

The answer does not seem to be the case, and to date, no one has been able to prove it.

= So should I forget about the idea of becoming a millionaire through math?
I have to be honest: yes. In any case, researchers aren't trying to solve this problem to get rich. Not only does it hold immeasurable sentimental value for them, but solving it would also drastically change our view of mathematics and computer science, if not the world itself. In fact, the answer to $"P" = "NP"$ doesn't really "matter"; in reality, experts in the field are convinced that the answer is no (99% of the top experts in the field believe this#footnote[A #link("https://www.cs.umd.edu/users/gasarch/BLOGPAPERS/pollpaper3.pdf")[great poll paper by William I. Gasarch] illustrates the scientific consensus on the P vs. NP problem; it's very interesting.]). On the other hand, proof that #smallcaps[P] is distinct from #smallcaps[NP] would inevitably yield revolutionary mathematical tools, or at least a breakthrough in complexity theory. If you still hold out hope that #smallcaps[P = NP], imagine the consequences as well. If such a proof were to emerge and provide a way to find a polynomial-time algorithm for all #smallcaps[NP] problems, it would have an impact on the algorithms we use every day, particularly on the accuracy of our calculations (many hard #smallcaps[NP] algorithms today rely on approximation algorithms). It is impossible to predict what such proof might lead to: the consequences may remain theoretical, very limited, even if interesting to researchers, or they may have very practical applications, such as in the study of the genome, in cryptography (which protects our messages and banking transactions every day), in physics, and so on.

The sad truth is that we will probably never know. I'd like to quote my professor of _Complexity Theory & Cryptography_, who made a lasting impression on me when he said #quote[I will probably never see a solution to P vs. NP, nor will my children... or my grandchildren...]

= Can I ask a question?
#spoiler([I feel like the problem in @sat is simple; I figured it out in just a few minutes. Why isn't this problem included in P?], [I illustrated #smallcaps[SAT] using a small example with only three participants. But it's important to remember that in complexity theory, as discussed in @complexity, complexity isn't measured by the time it takes to solve a problem, and certainly not based on such a small example. #smallcaps[3-SAT] is an exponential problem, meaning that the best algorithm to date for solving it has exponential complexity depending on the number of participants ($n$) in my analogy in @sat. With $n = 3$, as in my example, the complexity isn't noticeable in practice; it's only when you start adding more and more participants that the complexity skyrockets.])

#spoiler("What are the mathematical foundations needed to understand P vs. NP in more detail?", [In a #colored(level-one.lighten(50%))[Level-1 post], I would introduce the reader to: deterministic and nondeterministic Turing machines to provide the true formal definition of complexity classes; Landau notation $cal(O)(.)$, which better describes complexity than words alone; and Boolean logic, including disjunctions and conjunctions, to formally describe #smallcaps[SAT].])

])
