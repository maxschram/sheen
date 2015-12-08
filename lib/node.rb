module DOM
  class Node
    attr_accessor :children

    def initialize(children)
      @children = children
    end
  end

  class Text < Node
    attr_accessor :string
    def initialize(string)
      @string = string
      super([])
    end

    def is_elem?
      false
    end

    def pretty_print(level = 0)
      "\t" * level + string
    end
  end
  class Element < Node
    attr_accessor :name, :attrs
    def initialize(name, attrs, children)
      @name = name
      @attrs = attrs
      super(children)
    end

    def is_elem?
      true
    end

    def id
      attrs[:id]
    end

    def classes
      attr['class'].split(' ')
    end

    def append(node)
      children.push(node)
    end

    def pretty_print(level = 0)
      tabs = "\t" * level
      open_tag = "#{tabs}<#{name}#{format_attrs}>"
      child_tags = children.map { |c| c.pretty_print(level + 1)}.join("\n")
      close_tag = "#{tabs}</#{name}>"
      if children.length > 0
        [open_tag, child_tags, close_tag].join("\n")
      else
        open_tag.insert(-2, " /")
      end
    end

    private

    def format_attrs
      formatted = attrs.map { |name, val| "#{name}=#{val}"}.join(" ")
      formatted.prepend(" ") if attrs.length > 0
      formatted
    end
  end
end
