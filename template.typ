#import "tag.typ"
#import "@preview/cetz:0.5.2"

#let level-zero = rgb("#32a852")
#let level-one = rgb("#a89332")
#let level-two = rgb("#a84032")
#let level-text = ("0": "General audience", "1": "Informed audience", "2": "Experienced audience")
#let level-hover = ("0": "No prior experience/background in the field is required; the target audience is very broad", "1": "Discerning reader who wants to delve deeper into the Level-0 post", "2": "An audience with the necessary background to understand technical and advanced details")

#let note(content) = tag.div(class: "note", content)

#let colored(color, content) = tag.span(style: "color:"+color.to-hex(), class: "colored-text", content)

#let centered(..args, content) = tag.div(..args, class: "center", content)

#let canvas(content, caption: none, ..args) = {
  let fig-label = args.at("label", default: none)

  let center-args = if fig-label != none {
    (id: fig-label)
  } else {
    ()
  }

  centered(
    ..center-args,
    if caption != none [
      #figure(html.frame(cetz.canvas(content)), caption: caption)

      #if fig-label != none {
        label(args.at("label"))
      }
    ] else {
      html.frame(cetz.canvas(content))
    }
  )
}

#let code(code, ..args) = {
  canvas(..args, {
    cetz.draw.content((0, 0), code)
  })
}

#let spoiler(name, content) = [
  #centered[
    #tag.details[
      #tag.summary[#name]

      #content
    ]
  ]
]

#let post(key, content) = [
  #let post = toml("posts.toml").at(key)
  #let title = post.title
  #let date = post.date.display()
  #let level = post.level
  #let tags = post.tags
  
  #set heading(numbering: "1.1 ~")
  #show ref: it => {
    if target() == "html" {
      tag.a(href: "#" + str(it.target), it)
    } else {
      it
    }
  }

  #show footnote: it => {
    context {
      let count = counter(footnote).get().at(0)
      if target() == "html" {
        tag.a(
          id: "footnote-" + str(count) + "-number",
          href: "#footnote-" + str(count) + "-body",
          it
        )
      } else {
        it
      }
    }
  }

  #show math.equation.where(block: false): it => {
    set text(fill: white);
    if target() == "html" {
      tag.span(role: "math", html.frame(it))
    } else {
      it
    }
  }

  #show math.equation.where(block: true): it => {
    set text(fill: white);
    if target() == "html" {
      tag.figure(role: "math", html.frame(it))
    } else {
      it
    }
  }
  
  #show figure.caption: set text(fill: white, size: 2em)
  #set figure(gap: 2em)

  #tag.html[
    #tag.head[
      #tag.meta(name: "viewport", content: "width=device-width, initial-scale=1")
      #tag.meta(http-equiv: "content-type", content: "text/html; charset=UTF-8")

      #tag.link(rel: "stylesheet", href: "style.css")

      #tag.title(title)
    ]

    #tag.body[
      #tag.div(class: "header")[
        #tag.div(class: "nav left")[
          #tag.div[#link("index.html")[Home]]
          #tag.div[#link("about-me.html")[About me]]
        ]
        #tag.div(class: "center")[
          #tag.div(class: "title")[#title]
          #tag.div(class: "subtitle")[#date]
          #tag.div(class: "level"+str(level), title: level-hover.at(str(level)))[#level-text.at(str(level))]
          #for t in tags [ #tag.span(class: "tag")[#t] ]
        ]
      ]

      #tag.div(class: "main")[
        #tag.div(class: "text")[
          #content

          #context {
            let notes = query(footnote)

            if notes.len() > 0 {
              tag.hr()
            }

            tag.div(class: "footnotes",
              for (i, note) in notes.enumerate() {
                tag.div[
                  #tag.a(
                    id: "footnote-" + str(i + 1) + "-body",
                    class: "footnote-body",
                    href: "#footnote-" + str(i + 1) + "-number",
                    str(i + 1)
                  )
                  #note.body
                ]
              }
            )
          }

        ]
      ]
    ]

    #tag.div(class: "footer")[
      Made with _passion_ (and technically with #link("https://typst.app/")[Typst])
    ]
  ]
]
