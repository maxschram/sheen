require './lib/dom.rb'

e1 = DOM.elem("div")
e2 = DOM.elem("a", { href: "google.com"})
t1 = DOM.text("Hello world")
t2 = DOM.text("So nice")


e1.append(t1)
e1.append(e2)
e2.append(t2)

puts e1.pretty_print
