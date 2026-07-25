#import "/template.typ": *

#show: content => post("collatz", 0,
[
"Mathematics may not be ready for such problems" said Paul Erdős, one of the greatest mathematicians of the 20th century. However, I assure you that this problem, or at least its description, could be understood by a child as young as 10. Do you think I'm exaggerating? A 10-year-old has no background in math, aside from addition, multiplication, and a basic grasp of division; you might say. Yet that's all you need to understand this problem. It is by far the simplest to explain, visualize, and understand; just as it is surely by far the most complex to solve. Do you know how to divide a number by 2 or multiply it by 3? Then you're ready to discover one of the most famous problems in mathematics, one that has baffled even the greatest geniuses on the planet as they've tried to solve it: the *Collatz conjecture*.

= What is this problem with its paradoxical difficulty?
Pick an number, any positive integer you like.

+ If it is even, divide it by 2;
+ If it is odd, multiply it by 3 and add 1;
+ Go back to step one with the number you obtained.

Here is the statement of the problem. That's all.

])