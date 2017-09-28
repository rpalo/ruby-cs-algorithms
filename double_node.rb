require_relative 'node'

# Node used in Doubly Linked Lists
class DoubleNode < Node
  attr_accessor :prev, :next, :data

  def initialize(value)
    super
    @prev = nil
  end
end