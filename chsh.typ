#import "template.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#let card(color) = box(fill: color, width: 14pt, height: 20pt, radius: 2pt, stroke: 0.5pt + luma(100), baseline: 25%)
#let green-card = card(rgb("48bb78"))
#let pink-card = card(rgb("ed64a6"))
#let coin(letter, fill-color) = box(
  width: 26pt,
  height: 26pt,
  radius: 13pt, // Half of the width/height makes a perfect circle
  fill: fill-color,
  stroke: 0.5pt + luma(100),
  baseline: 25%, // Keeps it aligned nicely with the text
  align(center + horizon)[#text(size: 15pt, weight: "bold", letter)]
)
#let heads-coin = coin("H", gradient.linear(rgb("f8fafc"), rgb("94a3b8"), angle: 45deg)) // Silver
#let tails-coin = coin("T", gradient.linear(rgb("fef08a"), rgb("d97706"), angle: 45deg)) // Gold

#show: content => post("chsh",
[

I know what you're thinking: "Quantum physics and games, seriously?". If you don't believe me if I tell you that the game I'm going to introduce to you today will be fun... well, fair enough. However, I guarantee you'll find this a fascinating read, of a game that is essential to understanding the fundamental properties of quantum mechanics. Don't worry, since this post is #colored(level-zero.lighten(50%))[intended for a non-expert audience], I'll try to keep the math to a minimum while still preserving the magic of the concepts behind it. Other posts on this same topic will go into greater depth, whether for curious readers who #colored(level-one.lighten(50%))[already have a basic understanding of quantum physics] or #colored(level-two.lighten(50%))[for experts in the field] who want to understand each equation in detail.

So let's have some _fun_!

= Did you say _quantum_?
Yes... Please forgive me if this word scares you. But rest assured: I'm only going to cover the basics here, without using a single equation. Quantum physics is the branch of science that describes how nature behaves at extremely small scales. So we're talking here about describing the behavior of atoms, electrons; in short, tiny building blocks of the universe. Since these extremely small objects do _not_ behave like everyday objects (classical objects), they therefore follow different rules.

In this section, I will try to explain the two fundamental properties of quantum objects: *superposition* and *entanglement*.

== Superposition <superposition>
I'm not going to give the true and rigorous definition of *quantum superposition*, because I've made a point of not doing it mathematically. Let's try to get a sense of the general idea.

In physics, we like to describe objects (or a _system_) as *states*, meaning the set of variables describing them at a given instant. Classically, physics allows us to say "Such-and-such an object has such-and-such a position and such-and-such a velocity" at time $t$. If you remember your middle school physics classes, you may recall the equations used to describe the motion of a tennis ball (that is, its position or acceleration over time, for example). However, when it comes to very small objects, this so-called _classical_ physics no longer applies, and their mechanics are different; this is referred to as _quantum_ mechanics.

Superposition is, then, the idea that a quantum object can exist in a combination of multiple possible states at the same time. It may seem strange: classical physics allows us to predict the trajectory of any object, as long as we know its state at the moment just before; but in quantum physics, it is impossible to know the state of the system before observing it. This principle that "observation determines the quantum state" is another fundamental principle of quantum mechanics. In other words, as long as a very small object, such as a particle, is not observed, its state remains in a quantum superposition. There are many analogies used to describe this phenomenon (you may have already heard of *Schrödinger's cat*, which is both dead and alive as long as the box remains unopened), but I feel that they can be misleading to the uninitiated because they use macroscopic objects (like a cat) to describe quantum behavior that normally occurs only with very small objects, such as particles. These analogies tend to offer a classical explanation of a system in quantum superposition, which can lead to many comprehension issues and paradoxes, making quantum mechanics even more difficult for beginners to understand than it already is.

== Entanglement
*Entanglement* is an even more complex concept to grasp, but it is essential here for understanding the game in the next section.

The idea is that two particles (_i.e._ quantum states) can become linked so deeply that they must be described as parts of a single quantum system, even when they are far apart. Imagine that we have two entangled electrons (they are quantum particles), and that you go on a trip to New York with one of them while I stay in Paris with the other. Let's assume that each of these electrons is in a quantum superposition (see @superposition), so that they are simultaneously in a state we'll call _up_ and in a state we'll call _down_: observing (and thus measuring) this electron will yield _up_ half the time and _down_ half the time (as if we were flipping a coin). The principle of entanglement states that the result of my measurement in Paris will be linked to the result of your measurement in New York. You can see this as a special pair of dice that are correlated: whenever one shows an _up_, the other shows a _down_, and this, even though we hadn't communicated!

If you think this is impossible, that it is magic, or that physicists have lost their minds by making the biggest mathematical mistake of their lives, you should know that many experiments have demonstrated and utilized entanglement: quantum particles just often behave as though the properties are not simply predetermined in that classical way, and instead, the entangled pair acts as a single quantum system until measurements are made. And if you're still having trouble with this concept, don't worry, Einstein did too.

= It's recess, can we play?
I'm going to disappoint you a little, but when I mentioned _game_, I was referring to a mathematical abstraction used to highlight strategies described by mathematical models: this is what we call *Game Theory*. This field is important in quantum mechanics because the mathematical models used to describe strategies and expected payoff sometimes yield better results when *quantum strategies* are employed. This post focuses on a specific game, which itself belongs to a specific class of games (more details are provided in the higher-level posts on this topic); it is called the *CHSH game*.

== How do you play it?
You need two players and a referee. In scientific literature, it is customary to refer to the participants in a protocol, a thought experiment, or a game as Alice and Bob. These will therefore be the names of our two players. The CHSH game is a cooperative game, so Alice and Bob do _not_ play against each other; instead, they aim to win together (against the referee, even though he can be considered neutral). Before they start, Alice and Bob can plan their strategy; they can literally tell each other everything and share everything. But once the game begins, they are _absolutely not allowed_ to communicate with each other during the game. It's important to understand that communicating during the game is essentially cheating, and even though this #colored(level-zero.lighten(50%))[Level-0 post] is meant to involve as little math as possible, it's easy to prove that communicating gives both players a $100%$ success rate (and, indeed, makes the game _really_ no fun at all this time). If you want to make sure no one cheats, separate Alice and Bob far enough apart so that the speed of light isn't fast enough for them to communicate quickly enough during the game.

The referee begins by flipping a coin and tells Alice the result (_heads_ or _tails_). He does the same with Bob. Alice and Bob have no idea what their teammate's result is. Alice and Bob must then each give an answer to the referee. To simplify things, their possible answers are a _pink card_ or a _green card_, but they can give their answer directly (_deterministic_ answer) or give a random card to the referee (_probabilistic_ answer). Remember that they cannot communicate with each other during the game to agree on their answer, but they can for sure think through a strategy before the game begins to anticipate how they will respond to the referee's question.

#centered(html.frame(scale(50%, figure(diagram(
    node-stroke: 1.3pt + luma(110),
    node-fill: rgb("fafafa"),
    node-inset: 18pt,
    spacing: (5.5cm, 4.2cm),

    // 1. The Referee
    node((1, 0), align(center)[
      *Referee*
    ],
         corner-radius: 8pt, 
         name: <referee>, 
         fill: rgb("eef5fd"), 
         stroke: 1.5pt + rgb("2b6cb0"),
         width: 6.5cm),

    // 2. The Players
    node((0, 1), align(center)[*Alice*], 
         corner-radius: 7pt, 
         name: <alice>, 
         width: 4.8cm),

    node((2, 1), align(center)[*Bob*], 
         corner-radius: 7pt, 
         name: <bob>, 
         width: 4.8cm),

    // --- EDGES: REFEREE <-> ALICE ---
    edge(<referee>, <alice>, "-|>",
         align(center)[#heads-coin #tails-coin],
         label-side: right,
         label-pos: 0.45,
         bend: -20deg,
         stroke: 1.5pt + rgb("2b6cb0")),
         
    edge(<alice>, <referee>, "-|>",
         align(center)[#pink-card #green-card],
label-side: right,
         label-pos: 0.45,
         label-sep: -10pt,
         bend: -20deg,
         stroke: 1.5pt + rgb("38a169")), // Green line for answer

    // --- EDGES: REFEREE <-> BOB ---
    edge(<referee>, <bob>, "-|>",
         align(center)[#heads-coin #tails-coin],
         label-side: left,
         label-pos: 0.45,
         label-sep: 10pt,
         bend: 20deg,
         stroke: 1.5pt + rgb("2b6cb0")),
         
    edge(<bob>, <referee>, "-|>",
         align(center)[#pink-card #green-card],
         label-side: left,
         label-pos: 0.45,
         label-sep: -10pt,
         bend: 20deg,
         stroke: 1.5pt + rgb("38a169")), // Green line for answer

    // --- EDGE: STRICT ISOLATION ---
    edge(<alice>, <bob>, "|-|",
         align(center)[#text(rgb("c53030"), weight: "bold")[No Communication]],
         label-pos: 0.5,
         label-side: center,
          bend: -30deg,
         stroke: (paint: rgb("e53e3e"), dash: "dashed", thickness: 1.4pt))
  ), caption: [CHSH game interactions.]))))
  
== How do you win?
- If the referee has given _heads_ for Alice and Bob, they win if they both tell the referee two different card colors ;
- Otherwise, they win if they both chose the same color (two _green_ or two _pink_), regardless of the referee's question (_heads_/_tails_, _heads_/_heads_, _tails_/_tails_).

])
