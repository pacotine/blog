#import "../engine.typ": *
#show: styling

#let oscillator = ((2, 2), (1, 2), (3, 2))
#simulate(oscillator, (:), 5, 20)