#let styling(it) = {
  set page(height: auto, width: auto, margin: 0.5cm, fill: black)
  set text(fill: white)
  it
}

#let neighbor_count(instance) = {
  let neighbors = (:)
  for (x, y) in instance {
    for dx in (-1, 0, 1) { for dy in (-1, 0, 1) {
      if (dx, dy) != (0, 0) {
        let neighbor = (str(x+dx), str(y+dy)).join(", ")
        neighbors.insert(neighbor, neighbors.at(neighbor, default: 0)+1)
      }
    }}
  }

  return neighbors
}

#let render_board(instance, pal, i, size) = [
  #grid(rows: size, columns: size, stroke: (x, y) => if (x, y) in instance {black} else {white}, inset: 1em, fill: (x, y) => if (x, y) in instance { if pal.len() == 0 { white } else { pal.at((str(x), str(y)).join(", "), default: white) } })
  $s = #i$
]

#let next_instance(current) = {
  let next = ()
  for (cell, count) in neighbor_count(current).pairs() {
    let c = cell.split(", ")
    let ca = (int(c.at(0)), int(c.at(1)))
    if count == 3 or (count == 2 and ca in current) {
      next.push(ca)
    }
  }

  return next
}

#let simulate(state, pal, size, end) = {
  for i in range(end) {
    render_board(state, pal, i, size)
    if i != end - 1 { pagebreak() }
    state = next_instance(state)
  }
}