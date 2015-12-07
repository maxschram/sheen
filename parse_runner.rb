require './lib/parser'
require 'byebug'

source = File.read('./index.html')

tree = DOM::Parser.parse(source)
puts tree.pretty_print
