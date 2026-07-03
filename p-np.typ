#import "template.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/lilaq:0.6.0" as lq

#show: content => post("p-np",
[

In 2000, the #link("https://www.claymath.org/millennium-problems/")[Clay Mathematics Institute] selected seven open problems and offered a \$1 million reward to anyone who could provide a correct solution to one of them. Among these problems of paramount importance in science, known as the *Millennium Problems*, one stands out for its complexity, its apparent simplicity given the statement of the problem, and its potential impact if it were to be solved. Today I'd like to introduce you to the most iconic open problem in mathematics and computer science: the *P vs. NP* problem. How do we define what is effective and what is not? How do we solve a problem effectively? Does a problem that is simple to solve always have a solution that is simple to verify? What if the opposite were true? Are you ready to delve into the fascinating world of complexity theory through what is surely the most important mathematical problem of the millennium? Just a friendly reminder: don't worry, this is a #colored(level-zero.lighten(50%))[Level-0 post], so I'll try to use as little math as possible, even though that will be a challenge here.

Let's get _rich_!

= What is a problem? <problem>
In *theoretical computer science*, a problem is defined as anything that can be solved by what is called an *algorithm*, specified by an input and a desired output. An algorithm, a finite sequence of (mathematically rigorous) instructions, can be thought of as a recipe, where the ingredients are the inputs and the desired outcome of the recipe is the output. There are different types of problems: for example, we distinguish between those that are posed as yes/no questions (*decision problems*) and those in which we seek a valid solution for a given input (*search problems*). A simple example of a problem is finding the minimum in a list of numbers (the algorithm that solves this involves traversing the entire list and updating the minimum each time a new one is found). Another problem, a more difficult one this time, is solving a Sudoku puzzle. In fact, as long as there is a way to formulate a problem in a mathematically abstract way, we can then investigate whether there is an algorithm capable of solving it.

The work of a researcher in *computational complexity theory*#footnote[A field of research at the intersection of mathematics and theoretical computer science.] is to "zoologize" these problems, that is, to classify them according to a criterion known as their *complexity*#footnote[To be more precise, complexity is a metric for algorithms that solve problems, and so when we talk about the _complexity of a problem_, we are referring to the complexity of the best-known algorithm that solves it.].

== When you say _complexity_, do you mean how difficult the problem is?
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

The \$1 million Millennium Prize Problem, thus, seeks to determine whether this is a strict inclusion ($"P" subset.neq "NP"$ or $"NP" subset.not "P"$ which, mathematically, would imply that $"P" != "NP"$) or whether #smallcaps[NP] is also included in #smallcaps[P] (which, mathematically, would imply that $"P" = "NP"$).

= But then, how can we prove that $"P" eq.quest "NP"$?

])
