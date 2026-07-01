#import "template.typ": *

#show: content => post("p-np",
[

In 2000, the #link("https://www.claymath.org/millennium-problems/")[Clay Mathematics Institute] selected seven open problems and offered a \$1 million reward to anyone who could provide a correct solution to one of them. Among these problems of paramount importance in science, known as the *Millennium Problems*, one stands out for its complexity, its apparent simplicity given the statement of the problem, and its potential impact if it were to be solved. Today I'd like to introduce you to the most iconic open problem in mathematics and computer science: the *P vs. NP* problem. How do we define what is effective and what is not? How do we solve a problem effectively? Does a problem that is simple to solve always have a solution that is simple to verify? What if the opposite were true? Are you ready to delve into the fascinating world of complexity theory through what is surely the most important mathematical problem of the millennium? Just a friendly reminder: don't worry, this is a #colored(level-zero.lighten(50%))[Level-0 post], so I'll try to use as little math as possible, even though that will be a challenge here.

Let's get _rich_!

= What is a problem?
In *theoretical computer science*, a problem is defined as anything that can be solved by what is called an *algorithm*, specified by an input and a desired output. An algorithm, a finite sequence of (mathematically rigorous) instructions, can be thought of as a recipe, where the ingredients are the inputs and the desired outcome of the recipe is the output. There are different types of problems: for example, we distinguish between those that are posed as yes/no questions (*decision problems*) and those in which we seek a valid solution for a given input (*search problems*). A simple example of a problem is finding the minimum in a list of numbers (the algorithm that solves this involves traversing the entire list and updating the minimum each time a new one is found). Another problem, a more difficult one this time, is solving a Sudoku puzzle. In fact, as long as there is a way to formulate a problem in a mathematically abstract way, we can then investigate whether there is an algorithm capable of solving it.

The work of a researcher in *computational complexity theory*#footnote[A field of research at the intersection of mathematics and theoretical computer science.] is to "zoologize" these problems, that is, to classify them according to a criterion known as their *complexity*#footnote[To be more precise, complexity is a metric for algorithms that solve problems, and so when we talk about the _complexity of a problem_, we are referring to the complexity of the best-known algorithm that solves it.].

== When you say _complexity_, do you mean how difficult the problem is?
Not really. What really interests researchers in this field isn't how difficult a problem is to understand or solve (in the sense that the algorithm is lengthy or difficult to grasp), but rather how much resources (_time_ and _space_) it uses.

But how do we measure the time it takes for an algorithm to run? You'll agree with me that if you used a stopwatch to time an algorithm running on your laptop, the result would be very different from running the same algorithm on NASA's supercomputers. Indeed, it seems pointless to measure an algorithm's execution time in seconds. Instead, we prefer to count the number of basic instructions used during its execution. Let me explain with an example.

])
