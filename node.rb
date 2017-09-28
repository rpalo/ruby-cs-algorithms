# Simple Linked List Node
class Node
  attr_reader :data
  attr_accessor :next

  def initialize(value)
    @data = value
    @next = nil
  end
end