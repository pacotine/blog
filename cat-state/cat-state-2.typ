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
  Do you like cats? In the field of *quantum information*, we love them very much. Today, we're going to talk about *cat qubits*, whose properties offer hope for building a fault-tolerant quantum computer. The goal here is to introduce the concept of cat states, their use in quantum information, and their interesting properties in *quantum error correction (QEC)*. As a #colored(level-two.lighten(50%))[Level-2 post], a solid foundation in quantum mechanics and quantum information is essential to fully enjoy reading it.

  Let it _purr_...

  = What do you mean "a cat"? <cat>
  You're wondering. To understand why we are talking about cats here, let me define what is needed. Let's take, for example, two opposite-phase *coherent states*, i.e. quantum states of the *quantum harmonic oscillator*#footnote[Here the coherent states are defined in the Fock basis, whose states are eigenvectors of the Hamiltonian governing a quantum harmonic oscillator, such that $ket(n)$ corresponds to having $n$ excitations in the oscillator's electromagnetic field.]
  $ ket(alpha) = e^(-1/2abs(alpha)^2)sum_(n=0)^oo alpha^n/sqrt(n!)ket(n) $ <coherent_1>\
  
  $ ket(-alpha) = e^(-1/2abs(-alpha)^2)sum_(n=0)^oo (-alpha)^n/sqrt(n!)ket(n) $ <coherent_2>
  where $alpha in RR$ is the _coherent amplitude_. These states are not orthogonal, since $bracket(alpha, -alpha) = e^(-2 alpha^2)$, hence they cannot be distinguished. However, when $alpha$ increases, $e^(-2 alpha^2)$ decreases exponentially so that $ket(alpha)$ and $ket(-alpha)$ can be discriminated with a probability of failure that approaches zero exponentially with $alpha$. For this reason, we say that $ket(alpha)$ and $ket(-alpha)$ are _quasi-orthogonal_, for $alpha$ large enough.

  Now, if we sum these two states, we obtain a superposition of two macroscopically distinct states. This image might remind you of something: *Schrödinger's cat* thought experiment. Thus, the superposition $ ket(alpha) + ket(-alpha) $ is, up to normalization, called a *cat state*. Since $ ket(alpha) + ket(-alpha) prop 2e^(-1/2abs(alpha)^2)(alpha^0/sqrt(0!)ket(0)+alpha^2/sqrt(2!)ket(2)+dots+alpha^(2k)/sqrt(2k!)ket(2k))"," $ i.e. it contains only even Fock states, we say that it is an _even cat state_. Equivalently, since $ ket(alpha) - ket(-alpha) prop 2e^(-1/2abs(alpha)^2)(alpha^1/sqrt(1!)ket(1)+alpha^3/sqrt(3!)ket(3)+dots+alpha^(2k+1)/sqrt((2k+1)!)ket(2k+1))"," $ i.e. it contains only odd Fock states, we say that it is an _odd cat state_.

  We thus denote the normalized even and odd cat states as follows: $ #cat_plus = 1/sqrt(2(1+e^(-2abs(alpha)^2)))(ket(alpha)+ket(-alpha))"," $ <cat_plus>\
  
  $ #cat_minus = 1/sqrt(2(1-e^(-2abs(alpha)^2)))(ket(alpha)-ket(-alpha))"." $ <cat_minus>

  == And what about "cat qubits"?
  You probably know that one can encode information using continuous-variable systems, such as a harmonic oscillator realized in superconducting circuits. This is what we call *bosonic encoding*. That's great because it lets us encode information using the cat states we defined above: a qubit whose code space is defined by the two coherent states $ket(alpha)$ and $ket(-alpha)$. A *cat qubit* is then defined as the superposition of cat states: 

  $ ket(0)_c &:= (#cat_plus + #cat_minus)/sqrt(2)\ &= ket(alpha) + cal(O)(e^(-2abs(alpha)^2))"," $ <cat_0>\

  $ ket(1)_c &:= (#cat_plus - #cat_minus)/sqrt(2)\ &= ket(-alpha) + cal(O)(e^(-2abs(alpha)^2))"." $ <cat_1>

  This is equivalent to#footnote[You've probably noticed that the computational basis is changed to the basis along the $X$ axis. This is a convention, as outlined by the fundamental paper of #link("https://arxiv.org/abs/1312.2017")[Mazyar Mirrahimi et al.], for the sake of simplifying the logic gates presentation.] $ket(+)_c = #cat_plus$ and $ket(-)_c = #cat_minus$. You might find it a little easier to understand with a Bloch sphere (see @bloch_cat).

  #figure(html.frame(bloch_shpere), caption: [Bloch sphere representation of a cat qubit (2-component cat#footnote[Why 2-component? Because there exists another cat encoding called _4-component cat_ where a qubit is encoded in the superposition of four coherent states $ket(alpha)"," ket(-alpha)"," ket(i alpha)"," ket(-i alpha)$. This type of encoding is also useful in practice, but here I will focus only on 2-component cat.]).], gap: 2em)<bloch_cat>

  Such an encoding pictured in @bloch_cat is called a _cat code_.

  Another way to visualize these states is through their Wigner function. I used the #link("https://qutip.org/")[`qutip` package] to plot Wigner functions of coherent states and a cat state. #link("plot-code.html")[Here is the Python code] that was used to produce the Wigner functions plotted in @plot_cat.

  #figure(image("wigner_cat.png", width: 90%, height: 90%), caption: [Wigner function of an even cat state $#cat_plus$, defined in @cat, with $alpha=2$.])<plot_cat>

  The standard Wigner function of a (free and time-independent) cat state can be calculated#footnote[See the question in @ciaq to see how.]: $ W_"cat" (beta) = (2N^2)/pi (e^(-2abs(beta - alpha)^2) + e^(-2abs(beta + alpha)^2) + e^(-2 abs(beta)^2)cos(4Im(beta alpha^*)-phi)) $ for $ beta = 1/sqrt(2) (x + i p) $ the complex phase-space variable, and $alpha$ the amplitude.
  It consists of three pieces that we can recognize in @plot_cat: two Gaussians centered at $plus.minus alpha$ representing each state of the cat in phase-space, and an interference term between these two superposed states. These oscillatory fringes are the genuinely quantum part since they produce negative regions of the Wigner function.

  == So what's the point of these _cat codes_?
  The number one enemy of quantum information is, of course, noise. A qubit can be affected by it and undergo a *bit-flip* (switching $ket(0)$ and $ket(1)$) or a *phase-flip* (switching $ket(+)$ and $ket(-)$). QEC thus aims to provide techniques designed to protect quantum information from such errors arising from decoherence and noise. Correcting both types of errors requires error-correcting codes whose complexity is proportional to the square of the number of qubits (for example, by using _surface codes_).

  That's where the magic of cat codes comes in! Cat qubits have intrinsic resistance to bit-flip errors. Specifically, in the regime of $abs(alpha)$, the 2-component cat encoding can be exploited to simplify existing QEC protocols: the two coherent states separate for increasing values of $abs(alpha)$, the probability of a physical error induces a bit-flip exponentially decreases as $bracket(alpha, -alpha) prop e^(-4 abs(alpha)^2)$, i.e. exponentially. With this important property of cat qubits, we can assume bit-flip errors as of no consequence and, hence, can be disregarded completely. It then remains only to correct the remaining phase-flip errors by using a simple _repetition code_. This reduces the complexity of the problem to linear versus quadratic. Two dimensions vs. only one! Such a low overhead can help leading the race to building a fault-tolerant quantum computer.

  The important thing to remember is that, by the very nature of cat qubits, error correction is intrinsinc for bit-flips. As if bit-flips were corrected even before a QEC protocol was used, or as if cat qubits never "experienced" such errors. But why and how does that happen? Via the process called *two-photon dissipation*.

  = Two-photon what?
  _Two-photon dissipation_ is what stabilizes the cat qubits and gives them their resistance to bit-flips. Indeed, cat codes are encoded in an oscillator subspace that is fragile under ordinary noise. And to prevent the oscillator state from leaving the computational subspace driven by $ket(alpha)$ and $ket(-alpha)$, one needs an engineered loss process in which the oscillator loses or gains energy in pairs of photons, so the dynamics drive the mode toward a desired manifold of states rather than toward ordinary vacuum decay. That's the idea behind two-photon dissipation. Bit-flip errors are exponentially suppressed (with the mean number of photon $abs(alpha)^2$) if the stabilization rate realized by the two-photon dissipation is higher than that of typical errors.

  How does this work in reality? Although a complete and detailed description of this engineering process is beyond the scope of this post, I will try to present the key equations and fundamental concepts in order to better understand its importance in protecting cat qubits.

  == Dissipation?
  A qubit is never perfectly isolated: it interacts with an environment (electromagnetic modes, thermal photons, materials, etc.). Hence, the system is an _open quantum system_. What we need is then an equation that describes the coherent evolution, dissipation and irreversible process: this is the role of _master equations_. When the interaction between the system and the environment (the external quantum system, called the _bath_) is weak, any changes to the combined system over time can be approximated as originating from only the system in question: this is a _Markovian open quantum system_. A Markovian bath has no memory and information lost into the bath never comes back. One of the general forms of Markovian master equations is the Franke–Gorini–Kossakowski–Sudarshan–Lindblad master equation (often simply called a _Lindbladian_ or a _Lindblad master equation_). 
  
  A Lindbladian generalizes, in a way, the Schrödinger equation to open quantum systems: it preserves probability, positivity, and Hermicity. It has two parts:

  + The Hamiltonian (ordinary quantum evolution of energy) ;
  + The dissipative term $hat(L)$ (describes irreversible coupling to the environment).

  If we now imagine our open quantum system such that the environment removes photons two at a time, we obtain the so-called _two-photon dissipation_.

  == How can Lindbladian describe these kinds of systems?
  We are going to use the jump operator#footnote[Another name for the ladder operator of the quantum harmonic oscillator, such that $hat(a)ket(n)=sqrt(n)ket(n-1)$. This is a "jump" because we lower photon number by one.] $hat(a)$ so that we can define a two-photon loss by the Lindblad operator $ hat(L) = hat(a)^2"." $
  Indeed, you can notice that $ hat(a)^2ket(n) = sqrt(n(n-1))ket(n-2)"," $ i.e. we "lost" two photons. Notice also how the two-photon loss preserves parity, whereas single-photon loss flips parity. This is why this process was chosen for cat states stabilization, since cat states are parity eigenstates (see @cat)!

  However this Lindblad example operator is not the best to describe such a system. Pure $hat(a)^2$ loss alone would simply drain photons away until vacuum. We can use a more sophisticated and engineered process: $ hat(L) = hat(a)^2 - alpha^2 $ giving the Lindblad master equation $ dot(rho) = kappa_2 cal(D) [a^2 - alpha^2] rho $ where $dot(rho) equiv (d rho)/(d t)$ is the time derivative of the quantum state described by density operator $rho$ (the open system analogue of Schrödinger equation) and $kappa_2$ is the two-photon dissipation rate setting the speed of the engineered dissipation (in Hz).\
  $cal(D)[hat(L)]rho$ is called the _Lindblad dissipator_,  a superoperator defined as $ cal(D)[hat(L)] rho=hat(L) rho hat(L)^dagger- 1/2(hat(L)^dagger hat(L) rho+rho hat(L)^dagger hat(L))"." $
  It describes the effect of irreversible coupling to the environment with $hat(L)$ specifying the physical process (here, the physical process is the loss of two photons). We recognize two parts in it: $hat(L) rho hat(L)^dagger$ which describes stochastic jumps caused by the environment, and $-1/2(hat(L)^dagger hat(L) rho+rho hat(L)^dagger hat(L))$ which are the normalization and backaction terms. This more "complicared" master equation describes how the environment continuously drives the oscillator toward states satisfying $ (hat(a)^2 - alpha^2) ket(psi) = 0, $ namely $ket(alpha)$ and $ket(-alpha)$. This dissipation continuously keeps the state confined near the protected manifold. That is autonomous quantum error correction, or more specifically, an hardware level bit-flip error resilience!

  This is, of course, a simplifed model. In practice, you need to model the full physical device that generates the effective two-photon dissipation. If you're interested, you can check out the innovative and pioneering work of Alice&Bob#footnote[Alice&Bob is a French startup and a pioneer in quantum computers that use cat qubits. I relied heavily on #link("https://alice-bob.com/publications/")[their publications] when writing this post, as well as for my master's project, which focused on their technology.], where they use two bosonic modes: the storage mode that stores the cat qubit, and the _buffer_ mode intentionally very lossy. One of their #link("https://arxiv.org/abs/2302.06639")[significant experimental findings] showed that for each added photon in the cat-qubit state, the bit-flip time is multiplied by $4.2$, which is an exponential bit-flip error suppression.

  = Can I ask a question? <ciaq>
  #spoiler([How to compute the Wigner function plotted in @plot_cat?], [
  I aim to provide the calculations involved in the construction of the Wigner function of a coherent state $ket(alpha)$ and the Wigner function of a superposition of coherent state, namely a cat state.

  *Coherent state Wigner function*

  To better understand the construction of a coherent state Wigner function, we need to recall the definition and property of this state. A coherent state $ket(alpha)$ is the unique eigenstate of the annihilation operator $hat(a)$ with eigenvalue $alpha$, meaning it remains unchanged by the annihilation of field excitation: $hat(a)ket(alpha) = alpha ket(alpha)$. From the representation of $ket(alpha)$ in the Fock basis (see @cat), we recognize the power-series expansion of the exponential function, and thus $ ket(alpha) = e^(1/2abs(alpha)^2)e^(alpha hat(a)^dagger-alpha^ast hat(a))ket(0). $ <alpha_exp>

  Since $hat(a)$ and $hat(a)^dagger$ satisfy the canonical commutation relation, it derives from #link("https://homepage.univie.ac.at/reinhold.bertlmann/pdfs/T2_Skript_Ch_5.pdf")[the Baker-Campbell-Hausdorff formula] that the equation above leads to the equality $ ket(alpha) = D(alpha)ket(0) $ where $D(alpha) = e^(alpha hat(a)^dagger-alpha^ast hat(a)$ is called the _displacement operator_. Indeed, $D(alpha)$ acts on the vacuum state $ket(0)$ by displacing it into a coherent state of amplitude $alpha$. In the phase-space representation, $D(alpha)$ displaces a localized state by a magnitude $alpha$, which makes sense when we look at the Wigner function of $ket(alpha)$: a Gaussian blob of the vacuum, shifted so its center is at $alpha$. Indeed, let $psi_0$ be the wave function of the vacuum state $ psi_0 (x) = pi^(-1 \/ 4) e^(-x^2 \/ 2) $ then, it follows that a coherent state is a displaced vacuum state $ psi_alpha (x) = pi^(-1 \/ 4) e^(- ((x-x_0)^2)/2+i p_0 x- i/2 x_0 p_0) $ where $x_0$ and $p_0$ are the phase-space coordinates, related to coherent amplitude $alpha = 1/sqrt(2) (x_0 + i p_0)$, i.e. $x_0 = sqrt(2)Re(alpha)$ and $p_0 =sqrt(2)Im(alpha)$. Since the global phase is irrelevant for the Wigner function, we keep this definition of the coherent state wave function: $ psi_alpha (x) = pi^(-1 \/ 4)e^(-(x - x_0)^2/ 2)e^(i p_0 x). $ <wf_coherent> Our goal is now to compute the Wigner function $W_alpha (x, p)$ of a coherent state of wave function described above. First, we need to compute $ psi_alpha^* (x - y) = pi^(-1 \/ 4)e^(-(x - y -x_0)^2 \/ 2)e^(-i p_0 (x - y)) $ and $ psi_alpha (x + y)=pi^(-1 \/ 4)e^(-(x + y - x_0)^2 \/ 2)e^(i p_0 (x + y)) $ and multiplying them: $ psi_alpha^* (x - y) psi_alpha (x + y)=pi^(-1 \/ 2)e^(-1/2 [(x - y - x_0)^2 + (x + y - x_0)^2])e^(2 i p_0 y). $

  Using $ (a - y)^2 + (a + y)^2 = 2 a^2 + 2 y^2 $ with $a = x - x_0$, $ (x - y - x_0)^2 + (x + y - x_0)^2=2(x - x_0)^2 + 2 y^2 $ and therefore $ psi_alpha^* (x - y) psi_alpha (x + y)=pi^(-1 \/ 2)e^(-(x - x_0)^2)e^(-y^2)e^(2 i p_0 y) . $

  Now $ W_alpha (x, p)&=1/pi integral_(-infinity)^infinity dif y thin e^(2 i p y)psi_alpha^* (x - y) psi_alpha (x + y)\
  &= 1/(pi^(3 \/ 2))e^(-(x - x_0)^2)integral_(-infinity)^infinity dif y thin e^(-y^2)e^(2 i(p - p_0) y) . $<w_alpha>
  This Gaussian integral is $ integral_(-infinity)^infinity e^(-(a x^2 - b x + c)) thin d x = sqrt(pi/a) thin e^((b^2)/(4 a) - c) $ and taking $a=1$, $b=2i(p-p_0)$ and $c=0$, we obtain the Wigner function of a coherent state:
  $ W_alpha (x, p)=1/pi e^(-(x - x_0)^2 -(p - p_0)^2) . $ <wigner_coherent>
  This is a minimum-uncertainty Gaussian in phase-space, centered at $(x_0 , p_0)=(sqrt(2) Re(alpha), sqrt(2)Im(alpha))$. It is also possible to express it directly in terms of amplitude $alpha$, since the complex phase-space variable is $ beta = 1/sqrt(2) (x + i p), $ the result then becomes $ W_alpha (beta) = 2/pi e^(-2 abs(beta - alpha)^2). $ <wigner_pos> Similarly, $ W_(-alpha) (beta) = 2/pi e^(-2 abs(beta + alpha)^2). $ <wigner_neg>
  They both are simply two Gaussian peaks in phase-space. 

  *Cat state Wigner function*

  Let $ ket(psi_"cat") = N(ket(alpha)+e^(i phi)ket(-alpha)) $ <cat_phased> be an arbitrary cat state built from two coherent states of amplitude $alpha$ and $-alpha$, and $phi$ is some relative phase and $N$ the normalization constant. The density operator is $ rho_"cat" &= ket(psi_"cat")bra(psi_"cat")\ &= N^2(ket(alpha)bra(alpha) + ket(-alpha)bra(-alpha) + e^(-i phi)ket(alpha)bra(-alpha) + e^(i phi)ket(-alpha)bra(alpha)). $ Since the Wigner transform is linear, $ W_"cat" = N^2(W_alpha + W_(-alpha) + W_"int") $ is the Wigner function of a coherent-state cat, where $W_"int"$ comes from the off-diagonal coherence terms. The cross-term $ket(alpha)bra(-alpha)$ has Wigner function $ W_(alpha, - alpha)(beta)=2/pi e^(- 2 abs(beta)^2 - 2 abs(alpha)^2 + 4 beta alpha^*) $ which gives $ W_"int" (beta) = 4/pi e^(-2 abs(beta)^2)cos(4Im(beta alpha^*)-phi) $ up to normalization factor. Finally, combining everything, we obtain the standard Wigner function of a (free and time-independent) cat state:
  $ W_"cat" (beta) = (2N^2)/pi (e^(-2abs(beta - alpha)^2) + e^(-2abs(beta + alpha)^2) + e^(-2 abs(beta)^2)cos(4Im(beta alpha^*)-phi)). $ <wigner_cat>

  Notice also that for an even cat state or an odd cat state, defined in @cat, $alpha in RR$ and $phi=0$ or $phi=pi$ which simplifies the equation above and clearly shows two Gaussian packets separated in $x$ and oscillatory fringes along $p$.

  ])
])