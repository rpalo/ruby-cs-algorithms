require 'minitest/autorun'

require_relative 'linked_list'

class EmptyStackError < StandardError
end

# Stack Data Structure implemented with a Linked List
class Stack
  
  def initialize
    @list = LinkedList.new
  end

  def size
    @list.size
  end

  def empty?
    size.zero?
  end

  def push(item)
    @list.insert_front(Node.new(item))
    size
  end

  def pop
    raise EmptyStackError if empty?
    @list.remove_front.data
  end

  def peek
    raise EmptyStackError if empty?
    @list.head.data
  end
  
  alias top peek
end

# Test Cases for Linked List Stack
class StackTest < Minitest::Test
  def setup
    @s = Stack.new
  end

  def test_stack_is_empty_on_creation
    assert @s.empty?
  end

  def test_stack_can_push_values
    assert_equal 1, @s.push(42)
  end

  def test_stack_is_not_empty_after_push
    @s.push 42
    refute @s.empty?
    assert_equal 1, @s.size
  end

  def test_stack_can_pop_values
    @s.push 42
    result = @s.pop
    assert_equal 42, result
  end

  def test_stack_complains_on_empty_pop
    assert_raises EmptyStackError do
      @s.pop
    end
  end

  def test_stack_can_peek_and_top
    @s.push 42
    @s.push 13
    assert_equal 13, @s.peek
    assert_equal 13, @s.top
  end
end
