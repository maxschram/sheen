module Style
  def self.matches?(elem, selector)
    matches_simple_selector?(elem, selector)
  end

  def self.matches_simple_selector?(elem, selector)
    selector.tag_name == elem.name &&
      selector.id == elem.id &&
      selector.classes.all? do |class_name|
        elem.classes.includes?(class_name)
      end
  end

  def self.style_tree(root, stylesheet)
    return StyledNode.new(root, {}, []) unless root.is_elem?
    node = root
    values = specified_values(root, stylesheet)
    children = root.children.map do |child|
      style_tree(child, stylesheet)
    end
    StyledNode.new(node, values, children)
  end

  def self.matching_rules(elem, stylesheet)
    stylesheet.rules.select do |rule|
      rule.selectors.any? do |selector|
        matches?(elem, selector)
      end
    end
  end

  def self.specified_values(node, stylesheet)
    values = {}
    rules = matching_rules(node, stylesheet)
    rules.each do |rule|
      rule.declarations.each do |declaration|
        values[declaration.name] = declaration.value
      end
    end
    values
  end

  class StyledNode
    attr_reader :dom_node, :specified_values, :children
    def initialize(dom_node, specified_values, children)
      @dom_node = dom_node
      @specified_values = specified_values
      @children = children
    end
  end
end
