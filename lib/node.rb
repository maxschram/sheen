module DOM
  class Node
    attr_accessor :children

    def initialize(children)
      @children = children
    end
  end

  class Text < Node
    attr_accessor :string
    def initialize(string, children)
      @string = string
      super(children)
    end
  end

  class Element < Node
    def initialize(name, attrs, children)
      @name = name
      @attrs = attrs
      super(children)
    end

    def append(node)
      children.push(node)
    end
  end
end
