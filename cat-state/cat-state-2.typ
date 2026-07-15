#import "/template.typ": *
#import "@preview/cetz:0.4.2": angle, canvas, draw
#import draw: circle, content, line

#let cat_plus = $ket(cal(C)_alpha^+)$ //cat state +
#let cat_minus = $ket(cal(C)_alpha^-)$ //cat state -

#let bloch_shpere = canvas({
  // Helper coordinates
  let rad = 2.5
  let vec-a = (rad / 3, rad / 2)
  let phi-point = (rad / 3, -rad / 5)
  let mark = (end: "stealth", fill: black)
  
  // Axes
  let arrow-extend = 1.25

  line((0, 0), (-rad, -rad+1), mark: mark, stroke: white, name: "cat_plus")
  content("cat_plus.end", [$ket(+)_c = #cat_plus$], anchor: "east")

  line((0, 0), (rad, rad - 1), mark: mark, stroke: white, name: "cat_minus")
  content("cat_minus.end", [$ket(-)_c = #cat_minus$], anchor: "west")

  line((0, 0), (0, arrow-extend * rad), mark: mark, stroke: white, name: "cat_0")
  content("cat_0.end", [$ket(0)_c approx ket(alpha)$], anchor: "south")

  line((0, 0), (0, -rad * arrow-extend), mark: mark, stroke: white, name: "cat_1")
  content("cat_1.end", [$ket(1)_c approx ket(-alpha)$], anchor: "north")

  content((0, 0), [$crossmark$]) //center

  // Sphere
  circle((0, 0), radius: rad, stroke: white, fill: white.transparentize(80%))
  circle((0, 0), radius: (rad, rad / 3), stroke: (paint: white,dash: "dashed"), fill: gray.transparentize(80%))
})

#show: content => post("cat-state", 2,
[
  Do you like cats? In the field of *quantum information*, we love them very much. Today, we're going to talk about *cat qubits*, whose properties offer hope for building an fault-tolerant quantum computer. The goal here is to introduce the concept of cat states, their use in quantum information, and their interesting properties in *quantum error correction (QEC)*. As a #colored(level-two.lighten(50%))[Level-2 post], a solid foundation in quantum mechanics and quantum information is essential to fully enjoy reading it.

  Let it _purr_...

  = What do you mean "a cat"?
  You're wondering. To understand why we are talking about cats here, let me define what is needed. Let's take, for example, two opposite-phase *coherent states*#footnote[Here defined in the Fock basis, whose states are eigenvectors of the Hamiltonian governing a quantum harmonic oscillator, such that $ket(n)$ corresponds to having $n$ excitations in the oscillator’s electromagnetic field.], i.e. quantum states of the *quantum harmonic oscillator* 
  $ ket(alpha) = e^(-1/2abs(alpha)^2)sum_(n=0)^oo alpha^n/sqrt(n!)ket(n) $ <coherent_1>\
  
  $ ket(-alpha) = e^(-1/2abs(-alpha)^2)sum_(n=0)^oo (-alpha)^n/sqrt(n!)ket(n) $ <coherent_2>
  where $alpha in RR$ is the _coherent amplitude_. These states are not orthogonal, since $bracket(alpha, -alpha) = e^(-2 alpha^2)$, hence they cannot be distinguished. However, when $alpha$ increases, $e^(-2 alpha^2)$ decreases exponentially so that $ket(alpha)$ and $ket(-alpha)$ can be discriminated with a probability of failure that approaches zero exponentially with $alpha$. For this reason, we say that $ket(alpha)$ and $ket(-alpha)$ are _quasi-orthogonal_, for $alpha$ large enough.

  Now, if we sum these two states, we obtain a superposition of two macroscopically distinct states. This image might remind you of something: *Schrödinger's cat* thought experiment. Thus, the superposition $ ket(alpha) + ket(-alpha) $ is, up to normalization, called a *cat state*. Since $ ket(alpha) + ket(-alpha) prop 2e^(-1/2abs(alpha)^2)(alpha^0/sqrt(0!)ket(0)+alpha^2/sqrt(2!)ket(2)+dots+alpha^(2k)/sqrt(2k!)ket(2k))"," $ i.e. it contains only even Fock states, we say that it is an _even cat state_. Equivalently, since $ ket(alpha) - ket(-alpha) prop 2e^(-1/2abs(alpha)^2)(alpha^1/sqrt(1!)ket(1)+alpha^3/sqrt(3!)ket(3)+dots+alpha^(2k+1)/sqrt((2k+1)!)ket(2k+1))"," $ i.e. it contains only odd Fock states, we say that it is an _odd cat state_.

  We thus denote the normalized even and odd cat states as follows: $ #cat_plus = 1/sqrt(2(1+e^(-2abs(alpha)^2)))(ket(alpha)+ket(-alpha))"," $ <cat_plus>\
  
  $ #cat_minus = 1/sqrt(2(1-e^(-2abs(alpha)^2)))(ket(alpha)-ket(-alpha))"." $ <cat_minus>

  == And what about "cat qubits"?
  You probably know that one can encode information using continuous-variable systems, such as a harmonic oscillator realized in superconducting circuits. This is what we call *bosonic encoding*. That's great because it lets us encode information using the chat statuses we defined above: a qubit whose code space is defined by the two coherent states $ket(alpha)$ and $ket(-alpha)$. A *cat qubit* is then defined as the superposition of cat states: 
  $ ket(0)_c &:= (#cat_plus + #cat_minus)/sqrt(2)\ &= ket(alpha) + cal(O)(e^(-2abs(alpha)^2))"," $ <cat_0>\

  $ ket(1)_c &:= (#cat_plus - #cat_minus)/sqrt(2)\ &= ket(-alpha) + cal(O)(e^(-2abs(alpha)^2))"." $ <cat_1>

  This is equivalent to#footnote[You've probably noticed that the computational basis is changed to the basis along the $X$ axis. This is a convention, as outlined by the fundamental paper of #link("https://arxiv.org/abs/1312.2017")[Mazyar Mirrahimi et al.], for the sake of simplifying the logic gates presentation.] $ket(+)_c = #cat_plus$ and $ket(-)_c = #cat_minus$. You might find it a little easier to understand with a Bloch sphere (see @bloch_cat).

  #figure(html.frame(bloch_shpere), caption: [Bloch sphere representation of a cat qubit (2-component cat#footnote[Why 2-component? Because there exists another cat encoding called _4-component cat_ where a qubit is encoded in the superposition of four coherent states $ket(alpha)"," ket(-alpha)"," ket(i alpha)"," ket(-i alpha)$. This type of encoding is also useful in practice, but here I will focus only on 2-component cat.]).], gap: 2em)<bloch_cat>
])