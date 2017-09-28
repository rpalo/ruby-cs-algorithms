require 'minitest/autorun'

require_relative 'node'

# Error for when list is empty
class EmptyListError < StandardError
end

class NoNodeError < StandardError
end

# Implementation of simple Singly Linked List
class LinkedList
  attr_reader :head, :size

  def initialize
    @head = nil
    @size = 0
  end

  def insert_after(target, new_node)
    raise EmptyListError if @size.zero?

    new_node.next = target.next
    target.next = new_node
    @size += 1
  end

  def insert_front(new_node)
    new_node.next = @head
    @head = new_node
    @size += 1
  end

  def remove_after(target)
    raise EmptyListError if target.nil?
    raise NoNodeError if target.next.nil?

    deleted = target.next
    target.next = deleted.next
    @size -= 1
    deleted
  end

  def remove_front
    raise EmptyListError if @size.zero?

    deleted = @head
    @head = deleted.next
    @size -= 1
    deleted
  end
end

# Test Case for Linked List
class LinkedListTest < Minitest::Test
  def test_cant_insert_after_empty
    l = LinkedList.new
    assert_raises EmptyListError do
      l.insert_after(l.head, Node.new(42))
    end
  end

  def test_can_insert_new_node_at_front
    l = LinkedList.new
    bob = Node.new 42
    l.insert_front(bob)
    assert l.head == bob
  end

  def test_can_insert_node_after_other_nodes
    l = LinkedList.new
    bob = Node.new 42
    claire = Node.new 43
    l.insert_front(bob)
    l.insert_after(bob, claire)  # bob -> claire -> x
    assert l.head.next == claire
  end

  def test_can_remove_after_other_nodes
    l = LinkedList.new
    alice = Node.new 41
    bob = Node.new 42
    l.insert_front alice
    l.insert_after alice, bob
    assert_equal(bob, l.remove_after(alice))
    assert_equal(alice, l.head)
    assert_nil l.head.next
  end

  def test_cant_remove_after_on_last_node
    l = LinkedList.new
    alice = Node.new 41
    l.insert_front alice
    assert_raises NoNodeError do
      l.remove_after alice
    end
  end

  def test_cant_remove_after_on_empty
    l = LinkedList.new
    assert_raises EmptyListError do
      l.remove_after l.head
    end
  end

  def test_can_remove_first_node
    l = LinkedList.new
    alice = Node.new 42
    l.insert_front alice
    assert l.remove_front == alice
    assert l.head.nil?
  end

  def test_cant_remove_front_on_empty
    l = LinkedList.new
    assert_raises EmptyListError do
      l.remove_front
    end
  end
end
