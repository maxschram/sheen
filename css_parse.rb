require_relative 'lib/css_parser'

source = File.read('styles.css')

selectors = CSS::CSSParser.parse(source)
p selectors
