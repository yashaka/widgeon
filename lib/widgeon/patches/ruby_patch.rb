class Object
  def tap &block
    block.call self
    self
  end
end