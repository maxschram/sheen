require_relative "node"

module DOM
  def self.text(data)
    Text.new(data)
  end

  def self.elem(name, attrs = {}, children = [])
    Element.new(name, attrs, children)
  end
end
