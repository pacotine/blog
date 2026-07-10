#import "template.typ"
#import "tag.typ"

#let posts = toml("posts.toml")

  #tag.html[
    #tag.head[
      #tag.meta(name: "viewport", content: "width=device-width, initial-scale=1")
      #tag.meta(http-equiv: "content-type", content: "text/html; charset=UTF-8")

      #tag.link(rel: "stylesheet", href: "style.css")
      #tag.link(rel: "stylesheet", href: "https://cdn.jsdelivr.net/npm/katex@0.17.0/dist/katex.min.css")

      #tag.script(defer: "", src: "https://cdn.jsdelivr.net/npm/katex@0.17.0/dist/katex.min.js")
      #tag.script(defer: "", src: "https://cdn.jsdelivr.net/npm/katex@0.17.0/dist/contrib/auto-render.min.js")

      #tag.title("Guilford's blog of science")
    ]

    #tag.body[
      #tag.div(class: "header")[
        #tag.div(class: "nav left")[
          #tag.div[#link("index.html")[Home]]
          #tag.div[#link("about-me.html")[About me]]
        ]
      ]

      #tag.div(class: "main")[
        #tag.div(class: "text")[
        #for key in posts.keys() [
          #let post = posts.at(key)
          #let file-name = str(key)
          #template.centered[(#post.date.display()) $space$ #link(file-name + "/" + file-name + ".html")[#post.title]]
          ] 
        ]
      ]
    ]

    #tag.div(class: "footer")[
      Made with _passion_ (and technically with #link("https://typst.app/")[Typst])
    ]
  ]
