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
          #let title = post.title
          #let tags = post.tags
          #template.centered[*\~ #title \~*]
          #for entry-key in post.entry.keys() [
            #let entry = post.entry.at(entry-key)
            #let post-link = file-name + "/" + file-name + "-" + str(entry.level) + ".html"
            #template.centered[$gt.arc space$ (#entry.date.display()) $space$ #html.frame(square(fill: template.level-color.at(str(entry.level)), size: 0.5em)) $space$ #link(post-link)[Level-#entry.level]]
            ]
          ] 
        ]
      ]
    ]

    #tag.div(class: "footer")[
      Made with _passion_ (and technically with #link("https://typst.app/")[Typst])
    ]
  ]
