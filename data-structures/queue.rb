require 'minitest/autorun'

require_relative 'doubly_linked_list'

class EmptyQueueError < StandardError
end

# Implements a Queue Data Structure using a Doubly Linked List
class Queue

  def initialize
    @list = DoublyLinkedList.new
  end

  def size
    @list.size
  end

  def empty?
    size.zero?
  end

  def enqueue(item)
    @list.insert_end(DoubleNode.new item)
    size
  end

  def dequeue
    raise EmptyQueueError if empty?
    @list.remove_front.data
  end

  def peek
    raise EmptyQueueError if empty?
    @list.head.data
  end
end

# Test cases for Queue
class QueueTest < Minitest::Test
  def setup
    @q = Queue.new
  end

  def test_initial_queue_is_empty
    assert @q.empty?
  end

  def test_queue_can_enqueue
    @q.enqueue 42
    assert_equal 1, @q.size
  end

  def test_queue_is_not_empty_after_enqueue
    @q.enqueue 42
    refute @q.empty?
  end

  def test_queue_can_dequeue_when_items_present
    @q.enqueue 42
    @q.enqueue 13
    result = @q.dequeue
    assert_equal 42, result
  end

  def test_queue_complains_when_dequeue_on_empty
    assert_raises EmptyQueueError do
      @q.dequeue
    end
  end

  def test_queue_can_peek
    @q.enqueue 42
    @q.enqueue 13
    assert_equal 42, @q.peek
  end
end
