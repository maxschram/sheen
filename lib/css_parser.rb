require_relative 'parser'
require_relative 'css'

module CSS
  class CSSParser < ::DOM::Parser
    def self.parse(source)
      p = CSSParser.new(source)
      p.parse_rules
    end

    def initialize(source)
      super(source)
    end

    def parse_simple_selector
      selector = CSS::SimpleSelector.new
      while !eof? && valid_identifier_char(next_char)
        case next_char
        when '#'
          consume_char
          selector.id = parse_identifier
        when '.'
          consume_char
          selector.classes.push(parse_identifier)
        when '*'
          consume_char
        else
          selector.tag_name = parse_identifier
        end
      end
      selector
    end

    require 'byebug'

    def parse_identifier
      identifier = parse_tag_name
      identifier
    end

    def valid_identifier_char(c)
      (('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a + ['.', '#']).include?(c)
    end

    def parse_rule
      Rule.new(parse_selectors, parse_declarations)
    end

    def parse_rules
      rules = []
      until eof?
        rule = parse_rule
        puts "Finished rule"
        rules.push(rule)
      end
      rules
    end

    def parse_rule_name
      consume_whitespace
      name = consume_while do |c|
        c != ':'
      end
      consume_char
      name
    end

    def parse_rule_value
      consume_whitespace
      value = consume_while do |c|
        c != ';'
      end
      consume_char
      value
    end

    def parse_declaration
      consume_whitespace
      name = parse_rule_name
      value = parse_rule_value
      Declaration.new(name, value)
    end

    def parse_declarations
      declarations = []
      until eof?
        declaration = parse_declaration
        declarations.push(declaration)
        consume_whitespace
        if next_char == '}'
          consume_char
          consume_whitespace
          break
        end
      end
      declarations
    end

    def parse_selectors
      selectors = []
      until eof?
        selector = parse_simple_selector
        selectors.push(selector)
        consume_whitespace
        if next_char == ','
          consume_char
          consume_whitespace
        elsif next_char == '{'
          consume_char
          break
        else
          raise "Error"
        end
      end
      selectors
    end
  end
end
