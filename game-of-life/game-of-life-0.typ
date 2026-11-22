#import "/template.typ": *

#show: content => post("game-of-life", 0,
[
  Today I wanted to talk to you about the work of one of my favorite mathematicians, John Conway. A brilliant man who had a unique perspective on mathematics, and whose tragic death during the pandemic I deeply mourn. Conway has been so prolific that I could devote all my blog posts to his genius (and I will, to some extent!) without worrying about running out of content. Of all his creations and discoveries, the most famous is surely the one I'm going to tell you about: _The Game of Life_. I've developed a little tool#footnote[Thank you Typst, my dear, for being so wonderful. It only took me a few dozen lines of native code to write a GIF generator for game instances.] so you can witness this fascinating world right here on my blog, so please enjoy!

  _And God said, "Let there be light," and there was light._ (Genesis 1:3)

  = Game? Life?
  == A game without a player?
  Conway was an avid player. He loved games, but also appreciated their relevance to mathematics education. He enjoyed spending time playing Go and Backgammon with his colleagues during tea time (yes, he was English) in the common rooms at the University of Cambridge. In the 1970s, Conway became interested in *cellular automata*. Think of them as an abstractly formalized sandbox studied through the lens of mathematics: a grid of "cells" that change their state (_alive_ or _dead_, _black_ or _white_, _1_ or _0_, etc.) step by step based on simple rules and the states of neighboring cells. Once you set the initial state, a cellular automaton runs on "its own" since each cell updates from one generation to the next based only on its current state, its neighbors' states and the fixed rule set. The player makes no decisions#footnote[If it plays with a piece of paper and a pen, for example, it only changes the state of the game by systematically applying the predefined rules; therefore, it does not act like a sentient player, but like a machine that executes.], and can neither win nor lose. For this reason, it is said to be a *zero-player game*, i.e. a simulation game that does not require a player. 
  
  What particularly interested Conway was how minimal and predetermined rules could give rise to complex behaviors. He spent months testing rule variations until he found the simplest rules that allow the emergence of life-like behavior. It's important to remember that in the 1970s, computer simulations were not common, so Conway and his colleagues tested their rules by manually simulating the game's states on a Go board. A good choice for a two-state (alive or dead) 2D grid: each square on the board represented a cell, and the piece placed on it represented the cell's state (for example, white for _alive_ and black for _dead_), and each cell depended on the state of its eight neighboring cells.

  In the late 1970s, Conway had discovered the “perfect” rules that allowed him to tune the birth and survival thresholds, so populations would neither explode chaotically into infinity nor die out too quickly.\
  There are only 4 rules to follow at each stage between transitions:

  + _(Underpopulation)_ If a living cell has fewer than two living neighbors, it dies.
  + _(Overpopulation)_ If a living cell has more than three living neighbors, it dies.
  + _(Survival)_ If a living cell has two or three living neighbors, it remains alive.
  + _(Reproduction)_ If a dead cell has three living neighbors, it becomes alive.

  #figure(caption: [A simulation illustrating all the rules:

  (in purple) the cell at step $s = 0$ is underpopulated, so it dies at the next step $s = 1$;\
  (in red) the cell at step $s = 0$ is overpopulated, so it dies at the next step $s = 1$;\
  (in yellow) the cell is alive and has 2 living neighbors, so it survives at step $s = 1$;\
  (in green) the cell is dead at step $s = 0$ and has 3 living neighbors, so it becomes alive at step $s = 1$.],
  image("gen-gif/rules.gif", width: 50%, height: 50%))

  == Emergence?
  By defining these 4 simple rules, Conway sought to show that the *emergence* of complex patterns was possible. Not only do such patterns exist, but there are also many of them. So many, in fact, that a genuine taxonomy has been developed to classify them according to their behaviour#footnote[Given the abundance of diverse, autonomous and complex structures, a wiki was later created to explore the _zoology_ of the Game of Life.]. Without any central control, these minimal rules make it possible to generate self-organizing structures whose complexity causes them to behave like living systems: just as chemistry gives rise to biology without an external blueprint.

  Conway spent months with his students brute-force manual testing initial configurations (known as *seeds*) and observing their behavior. What is remarkable about this game is that, even though the rules are deterministic and predetermined, it is impossible to predict the behavior of the cells without simulating it.

  #figure(caption: [The _blinker_, a type of oscillator.],
  image("gen-gif/oscillator.gif", width: 50%, height: 50%))<blinker>

  There are three main types of patterns: *still lifes* (the ones that do not change from one generation to the next), *oscillators* (the ones that cycle through a fixed sequence of states; for example, @blinker shows an oscillator of period 2, meaning it returns to its original shape and position after 2 steps) and *spaceships* (the ones that translate themselves across the grid; see e.g. @glider).

  #figure(caption: [The _glider_, a type of spaceship.],
  image("gen-gif/glider.gif", width: 50%, height: 50%))<glider>

  Some patterns are significantly more complex because they can grow or produce smaller structures. These are then classified into categories such as *guns* or *breeders*.

  = How far can this go?
  == Self-replicating machines?
  

])