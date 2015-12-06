require './lib/dom.rb'

e = DOM.elem("div")
t = DOM.text("Hello world")

e.append(t)
