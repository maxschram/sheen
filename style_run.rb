require_relative 'lib/style'
require_relative 'lib/parser'
require_relative 'lib/css_parser'
require 'byebug'

source = File.read('index.html')
style_source = File.read('styles.css')

tree = DOM::Parser.parse(source)
stylesheet = CSS::CSSParser.parse(style_source)

style_tree = Style.style_tree(tree, stylesheet)
p style_tree

