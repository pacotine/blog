#import "../template.typ": *
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
Yes... Please forgive me if this word scares you. But don't worry: I'm only going to cover the basics here, without using a single equation. Quantum physics is the branch of science that describes how nature behaves at extremely small scales. So we're talking here about describing the behavior of atoms, electrons; in short, tiny building blocks of the universe. Since these extremely small objects do _not_ behave like everyday objects (classical objects), they therefore follow different rules.

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
You need two players and a referee. In scientific literature, it is customary to refer to the participants in a protocol, a thought experiment, or a game as Alice and Bob. These will therefore be the names of our two players. The CHSH game is a cooperative game, so Alice and Bob do _not_ play against each other; instead, they aim to win together #footnote[Against the referee, even though he can be considered neutral.]. Before they start, Alice and Bob can plan their strategy; they can literally tell each other everything and share everything. But once the game begins, they are _absolutely not allowed_ to communicate with each other during the game. It's important to understand that communicating during the game is essentially cheating, and it's easy to prove that communicating gives both players a $100%$ success rate (and, indeed, makes the game _really_ no fun at all this time). If you want to make sure no one cheats, separate Alice and Bob far enough apart so that the speed of light isn't fast enough for them to communicate quickly enough during the game#footnote[Since nothing travels faster than the speed of light, the information Alice could send to Bob to cheat is itself subject to this fundamental law.].

The referee begins by flipping a coin and tells Alice the result (_heads_ or _tails_). He does the same with Bob. Alice and Bob have no idea what their teammate's result is. Alice and Bob must then each give an answer to the referee. To simplify things, their possible answers are a _pink card_ or a _green card_, but they can give their answer directly (_deterministic_ answer) or give a random card to the referee (_probabilistic_ answer). Remember that they cannot communicate with each other during the game to agree on their answer, but they can for sure think through a strategy before the game begins to anticipate how they will respond to the referee's question.

#figure(html.frame(diagram(
    node-stroke: 1.3pt + luma(110),
    node-fill: rgb("fafafa"),
    node-inset: 18pt,

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
         label-sep: 10pt,
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
  )), caption: [CHSH game interactions.])
  
== How do you win?
Alice and Bob win if any of the following conditions is met:
- The referee has given _heads_ for Alice and Bob, and they both tell the referee two different card colors ;
- They both chose the same color (two _green_ or two _pink_), regardless of the referee's question (_heads_/_tails_, _tails_/_heads_, _tails_/_tails_).

#figure(html.frame(diagram(
    node-stroke: 1.3pt + luma(110),
    node-fill: rgb("fafafa"),
    node-inset: 18pt,

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
         align(center)[#heads-coin],
         label-side: right,
         label-pos: 0.45,
         label-sep: 10pt,
         bend: -20deg,
         stroke: 1.5pt + rgb("2b6cb0")),
         
    edge(<alice>, <referee>, "-|>",
         align(center)[#pink-card],
label-side: right,
         label-pos: 0.45,
         label-sep: -10pt,
         bend: -20deg,
         stroke: 1.5pt + rgb("38a169")), // Green line for answer

    // --- EDGES: REFEREE <-> BOB ---
    edge(<referee>, <bob>, "-|>",
         align(center)[#heads-coin],
         label-side: left,
         label-pos: 0.45,
         label-sep: 10pt,
         bend: 20deg,
         stroke: 1.5pt + rgb("2b6cb0")),
         
    edge(<bob>, <referee>, "-|>",
         align(center)[#green-card],
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
  )), caption: [Alice and Bob both got a _heads_, so they must each play a card of a different color to win.])<win-1>
  
#figure(html.frame(diagram(
    node-stroke: 1.3pt + luma(110),
    node-fill: rgb("fafafa"),
    node-inset: 18pt,

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
         align(center)[#tails-coin],
         label-side: right,
         label-pos: 0.45,
         label-sep: 10pt,
         bend: -20deg,
         stroke: 1.5pt + rgb("2b6cb0")),
         
    edge(<alice>, <referee>, "-|>",
         align(center)[#pink-card],
label-side: right,
         label-pos: 0.45,
         label-sep: -10pt,
         bend: -20deg,
         stroke: 1.5pt + rgb("38a169")), // Green line for answer

    // --- EDGES: REFEREE <-> BOB ---
    edge(<referee>, <bob>, "-|>",
         align(center)[#heads-coin],
         label-side: left,
         label-pos: 0.45,
         label-sep: 10pt,
         bend: 20deg,
         stroke: 1.5pt + rgb("2b6cb0")),
         
    edge(<bob>, <referee>, "-|>",
         align(center)[#pink-card],
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
  )), caption: [Alice and Bob obtained a combination other than _heads_/_heads_, so to win, they must give the referee two cards of the same color.])<win-2>
  
@win-1 and @win-2 show two scenarios in which Alice and Bob win. If, for example, in @win-2, Bob gave the referee a green card instead of a pink one, Alice and Bob would lose. Now that you're starting to grasp the concept of the game, try to figure out what the perfect (optimal) strategy would be, that is, the strategy that gives Alice and Bob the highest probability of winning.

== What's the best way to (classically) win this game?
The concept of strategy in game theory is best described using mathematics#footnote[For those who are interested, or those like me who think it's actually easier to formalize this game mathematically, I'm currently preparing posts at higher levels on this topic.], but to put it simply, a deterministic strategy is just the mapping of inputs (the referee's question and the coins) to outputs (Alice's and Bob's responses and the cards).

#figure(html.frame(diagram(
    node-stroke: 1.3pt + luma(110),
    node-fill: rgb("fafafa"),
    node-inset: 18pt,

    node((0, 0), align(center)[*Referee*],
         corner-radius: 8pt, 
         name: <referee>),
         
    node((1, 0), align(center)[*Alice*], 
         corner-radius: 7pt, 
         name: <alice>),     
	
    node((2, 0), align(center)[*Bob*], 
         corner-radius: 7pt, 
         name: <bob>),
         
    node((0, 1), align(center)[#tails-coin], name: <t>, fill: none, stroke: none),
    node((0, 2), align(center)[#heads-coin], name: <h>, fill: none, stroke: none),
    
    node((1, 1), align(center)[#pink-card], name: <ta>, fill: none, stroke: none),
    node((2, 1), align(center)[#green-card], name: <tb>, fill: none, stroke: none),
    node((1, 2), align(center)[#green-card], name: <ha>, fill: none, stroke: none),
    node((2, 2), align(center)[#green-card], name: <hb>, fill: none, stroke: none),
         
  )), caption: [A possible strategy for Alice and Bob.])<strategy>
  
@strategy illustrates one possible strategy for Alice and Bob: if they get _heads_/_heads_, they respond _green_/_green_; if they get _tails_/_heads_, they respond _pink_/_green_; and so on. You can have some fun trying to guess what their probability of winning is with this strategy, and try to figure out why it's $1/4$. Note that changing the colors of Alice's and Bob's cards in @strategy results in a new strategy. This raises several questions, such as: How many deterministic strategies are there? Is there one that guarantees Alice and Bob will always win? And if not, what is the best strategy?

For the first question, it's easy to verify that there are a total of $2^4 = 16$ possible deterministic strategies. Second, it is clear that there is no $100%$ winning strategy for Alice and Bob. Such a strategy would require Alice to communicate with Bob during the game, and this principle of correlation is related to what are known as *non-signaling strategies*. Strategies that are _not_ non-signaling are strategies that can be described as "illegal" because they involve cheating or a principle prohibited by the laws of physics. For the last question, I'll give you a little time to figure out the answer: determine the best deterministic strategy for Alice and Bob, that is, the strategy (like the setup described in @strategy) that they can plan before playing and that, when applied, maximizes their probability of success.

#figure(html.frame(diagram(
    node-stroke: 1.3pt + luma(110),
    node-fill: rgb("fafafa"),
    node-inset: 18pt,

    node((0, 0), align(center)[*Referee*],
         corner-radius: 8pt, 
         name: <referee>),
         
    node((1, 0), align(center)[*Alice*], 
         corner-radius: 7pt, 
         name: <alice>),     
	
    node((2, 0), align(center)[*Bob*], 
         corner-radius: 7pt, 
         name: <bob>),
         
    node((0, 1), align(center)[#tails-coin], name: <t>, fill: none, stroke: none),
    node((0, 2), align(center)[#heads-coin], name: <h>, fill: none, stroke: none),
    
    node((1, 1), align(center)[#pink-card], name: <ta>, fill: none, stroke: none),
    node((2, 1), align(center)[#pink-card], name: <tb>, fill: none, stroke: none),
    node((1, 2), align(center)[#pink-card], name: <ha>, fill: none, stroke: none),
    node((2, 2), align(center)[#pink-card], name: <hb>, fill: none, stroke: none),
         
  )), caption: [The best strategy for the CHSH game (give or take a color reversal).])<best-strategy>

@best-strategy illustrates one of the strategies that maximizes the probability of winning this game, which is $3/4$ (a $75%$ chance for both Alice and Bob to win). If you suggested another strategy that also gives a $75%$ chance of winning, you're also correct. In reality, there are variations of the optimal strategy. The general idea is this: since $3$ out of $4$ times Alice and Bob must choose the same color to win, and $1$ out of $4$ times they must choose different colors, it's clear that an optimal strategy is to always choose the same color, regardless of the referee's choice. Therefore, if the referee calls _heads_ for Alice and _heads_ for Bob, they will both choose the same color and lose. But since this event occurs with a probability of $1/4$, their chance of winning this game is $3/4$. 

Beautiful, isn't it? But I don't envy you for having found the best strategy. Would you be jealous if I told you that I know a way to win more than $75%$ of the time, thanks to quantum mechanics?

= And what about quantum physics in all this?
Here's the crucial moment of this post: the one that's supposed to blow your mind. Did I convinced you that the CHSH game could only be won with a probability of $3/4$ or less? Well, so did physicists... before they delved into the oddities of quantum mechanics.

== Quantum strategies
Remember the rules: Alice and Bob cannot communicate during the game, but there is nothing preventing them from devising a strategy in advance in any way. In this case, let's imagine that they share an entangled state. Nothing about the game rules changes, the only difference is that when they receive their question, they perform a particular measurement on their own particle. The measurement they choose depends on the question they received: this is a *quantum strategy*. Such a strategy therefore involves Alice and Bob entangling their respective particles before the game begins and devising a table that specifies what type of measurement to perform based on the referee's question. When the referee sends Alice the result of his coin toss, she will perform a measurement on her particle. But because it is entangled, this particle will yield a result correlated with Bob's when he also performs a measurement on his particle.

If you think that such a strategy amounts to cheating because they share an entangled state, remember that Alice and Bob can be separated on opposite sides of the universe so that the information about the cheating cannot reach them (they cannot send information faster than light). However, the correlation between measurement results will still be present, and that is the power of quantum entanglement.

== What are the results on CHSH?
By choosing the right entangled state and the right measurements, Alice and Bob can *win with a probability of about $85%$*. Yes, that's above the $75%$ threshold that classical strategies used to limit us to. Imagine you're that referee who, after playing hundreds of times with Alice and Bob, eventually realizes that they were winning $85%$ of the time. The first thing you'd think is "They must have cheated". So you separate them very far apart, so far that not even light can travel fast enough to allow them to communicate in any way. Then you play the game with them again, hundreds of times, and the results are the same: Alice and Bob manage to win far more often than classical physics predicts.

You're not the first to think this is strange; physicists have long pondered this question, and some great minds, like Einstein, saw flaws in the description of quantum mechanics. That's where the famous#footnote[He is considered one of the most important figures in quantum physics.] physicist John Bell comes in. Before Bell, many physicists hoped quantum mechanics was incomplete, and the idea was that maybe particles really do have definite properties all along, and quantum mechanics would simply be missing those hidden details (those *hidden variables*). John Bell arrived and asked: if there are hidden variables, what constraints would they impose on observable correlations? He then derived mathematical constraints called *Bell inequalities*: any theory in which particles merely carry pre-existing instructions must stay below a certain limit... and quantum mechanics predicts correlations beyond that limit! Not just on paper using math, but also experimentally in laboratories.

Now you understand that I tricked you and that the CHSH game isn't just a game for fun, but rather a reformulation of Bell's arguments in the form of a game (and also a protocol that can be carried out in a laboratory to verify the theory). The fact that Alice and Bob win the game more often than any classical strategy allows is equivalent to say that these correlations violate Bell's inequalities. The CHSH game demonstrates the full power of entanglement and its importance in the quantum advantage. It has been of paramount importance in quantum physics and led to Alain Aspect winning the Nobel Prize for experimentally demonstrating the violation of Bell's inequalities by, so to speak, "playing" this game in his laboratory with photons.

= Can I ask a question?
#spoiler("Why the name CHSH?", [It comes from John _C_ lauser, Michael _H_ orne, Abner _S_ himony, and Richard _H_ olt, four physicists who developed the most famous version of the inequality in 1969. The reason we prefer to use this one rather than Bell's version, published three years earlier, is because his version was not the easiest to test experimentally because it relied on assumptions that were difficult to realize in the lab. As for the CHSH game, it was invented later by quantum information researchers as a game-based interpretation of the CHSH inequality.])

#spoiler("I think you're not going into enough detail: how does entanglement provide an advantage, and why exactly 85%?", [This post is intended for a very broad audience that has likely never heard of entanglement before today. The $85%$ figure comes from a very precise calculation using Born's rule. I prefer to discuss this in more advanced-level posts, where mathematics isn't off-limits and where I can explain in detail the magic of quantum physics using equations and game theory formulations, thanks to the abstraction provided by game theory.])

#spoiler("Are there any other games like this?", [Yes! This one is the most important, but I don't think it's the most impressive. First of all, you should know that the CHSH game belongs to the family of nonlocal games (a cooperative game where players cannot communicate with each other during play). And among these games, the one I find most impressive is the Quantum Magic Square Game by Mermin-Peres. I'm even thinking of writing a post about it because it's so fascinating and interesting (for example, it introduces the concept of quantum pseudo-telepathy).])

])
