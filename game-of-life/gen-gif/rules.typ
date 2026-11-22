#import "../engine.typ": *
#show: styling

#let rules = ((1, 1), (17, 2), (16, 1), (15, 2), (16, 2), (15, 1), (1, 15), (2, 15), (3, 15), (15, 15), (16, 14), (17, 15))
#let pal = ("1, 1": purple, "16, 2": red, "2, 15": yellow, "16, 15": green)
#simulate(rules, pal, 19, 2)