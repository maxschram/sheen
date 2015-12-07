require_relative 'dom' 
module DOM
  class Parser
    attr_reader :source
    attr_accessor :current_tag, :pos

    def self.parse(source)
      nodes = self.new(source).parse_nodes()

      if nodes.length == 1
        nodes.first
      else
        DOM.elem("html", {}, nodes)
      end
    end

    def initialize(source)
      @source = source
      @pos = 0
    end

    def consume_char
      c = source[pos]

      # p "pos:#{pos} source_length:#{source.length}"
      c = '' if pos >= source.length
      @pos += 1
      c
    end

    def consume_while(&prc)
      res = ''
      while !eof? && prc.call(next_char)
        raise if pos >= source.length
        # p "pos:#{pos} source_length:#{source.length}"
        res += consume_char
      end
      res
    end

    def next_char
      source[pos]
    end

    def starts_with?(str)
      source[pos..-1].start_with?(str)
    end

    def consume_whitespace
      consume_while do |c|
        c == " " ||
          c == "\t" ||
          c == "\n"
      end
    end

    def parse_node
      consume_whitespace
      if next_char == "<"
        parse_element
      else
        parse_text
      end
    end

    def parse_tag_name
      consume_while do |c|
        (('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a).include?(c)
      end
    end

    def parse_element
      consume_char # <
      tag_name = parse_tag_name
      attributes = parse_attributes
      consume_char # >
      children = parse_nodes
      DOM.elem(tag_name, attributes, children)
    end

    def parse_text
      text = consume_while { |c| c != '<' }
      DOM.text(text)
    end
    require 'byebug'

    def parse_attributes
      attr_map = {}
      until next_char == ">"
        consume_whitespace
        name, val = parse_attr
        attr_map[name] = val
      end
      attr_map
    end

    def parse_attr
      name = parse_tag_name
      equals = consume_char
      # raise "Invalid attributes" unless equals == "="
      value = parse_attr_value
      [name, value]
    end

    def parse_attr_value
      open_quote = consume_char
      val = consume_while { |c| c != open_quote }
      close_quote = consume_char
      val
    end

    def parse_nodes
      nodes = []
      consume_whitespace
      until eof? || starts_with?("</")
        node = parse_node
        nodes.push(node)
      end
      nodes
    end

    def eof?
      pos >= source.length - 1
    end
  end
end
