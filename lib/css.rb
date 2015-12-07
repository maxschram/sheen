module CSS
  class Stylesheet
    attr_reader :rules
    def initialize(rules)
      @rules = rules
    end
  end

  class Rule
    attr_reader :selectors, :declarations
    def initialize(selectors, declarations)
      @selectors = selectors
      @declarations = declarations
    end
  end

  class SimpleSelector
    attr_accessor :tag_name, :id, :classes
    def initialize(tag_name = nil, id = nil, classes = [])
      @tag_name = tag_name
      @id = id
      @classes = classes
    end
  end

  class Declaration
    attr_reader :name, :value
    def initialize(name, value)
      @name = name
      @value = value
    end
  end

end
