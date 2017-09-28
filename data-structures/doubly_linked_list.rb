require 'minitest/autorun'

require_relative 'double_node'
require_relative 'linked_list'

# Doubly Linked List Implementation
class DoublyLinkedList
  attr_reader :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def insert_before(target, new_node)
    raise NoNodeError if @size.zero?
    before = target.prev
    after = target
    stitch new_node, before, after
  end

  def insert_after(target, new_node)
    raise NoNodeError if @size.zero?
    before = target
    after = target.next
    stitch new_node, before, after
  end

  def insert_front(new_node)
    before = nil
    after = @head
    stitch new_node, before, after
  end

  def insert_end(new_node)
    before = @tail
    after = nil
    stitch new_node, before, after
  end

  def remove(node)
    raise EmptyListError if @size.zero?

    after = node.next
    before = node.prev
    if after.nil?
      @tail = before
    else
      after.prev = before
    end
    if before.nil?
      @head = after
    else
      before.next = after
    end
    @size -= 1
    node
  end

  def remove_before(target)
    raise NoNodeError if target.prev.nil?

    remove(target.prev)
  end

  def remove_after(target)
    raise NoNodeError if target.next.nil?

    remove(target.next)
  end

  def remove_front
    remove(@head)
  end

  def remove_end
    remove(@tail)
  end

  private

  def stitch(new_node, before, after)
    new_node.prev = before
    new_node.next = after
    before.next = new_node unless before.nil?
    after.prev = new_node unless after.nil?
    @head = new_node if before.nil?
    @tail = new_node if after.nil?
    @size += 1
  end

end

class DoublyLinkedListTest < Minitest::Test
  def setup
    @d = DoublyLinkedList.new
    @alice = DoubleNode.new 41
    @bob = DoubleNode.new 42
    @claire = DoubleNode.new 43
  end

  def test_insert_front_on_empty_list
    @d.insert_front @bob
    assert_equal @bob, @d.head
  end

  def test_insert_end_on_empty_list
    @d.insert_end @bob
    assert_equal @bob, @d.tail
  end

  def test_insert_front_on_populated_list
    @d.insert_front @bob
    @d.insert_front @alice
    assert_equal @alice, @d.head
  end

  def test_insert_end_on_populated_list
    @d.insert_end @bob
    @d.insert_end @claire
    assert_equal @claire, @d.tail
  end

  def test_insert_after_works_when_list_populated
    @d.insert_end @bob
    @d.insert_after @bob, @claire
    assert_equal @claire, @d.tail
  end

  def test_insert_after_complains_when_no_nodes
    assert_raises NoNodeError do
      @d.insert_after @d.head, @alice
    end
  end

  def test_insert_before_works_when_list_populated
    @d.insert_front @bob
    @d.insert_before @bob, @alice
    assert_equal @alice, @d.head
  end

  def test_insert_before_complains_when_no_nodes
    assert_raises NoNodeError do
      @d.insert_before @d.tail, @alice
    end
  end
  
  def test_size_is_tracked_after_inserts
    assert_equal 0, @d.size
    @d.insert_front @claire
    assert_equal 1, @d.size
    @d.insert_front @bob
    assert_equal 2, @d.size
    @d.insert_front @alice
    assert_equal 3, @d.size
  end

  def test_node_can_be_removed
    @d.insert_front @bob
    result = @d.remove @bob
    assert_equal result, @bob
    assert_equal 0, @d.size
  end

  def test_remove_front_works_when_node_present
    @d.insert_front @bob
    @d.insert_front @alice
    result = @d.remove_front
    assert_equal @alice, result
    assert_equal 1, @d.size
    assert_equal @bob, @d.head
    assert_equal @bob, @d.tail
  end

  def test_remove_front_complains_when_empty
    assert_raises EmptyListError do
      @d.remove_front
    end
  end

  def test_remove_end_works_when_node_present
    @d.insert_front @bob
    @d.insert_front @alice
    result = @d.remove_end
    assert_equal @bob, result
    assert_equal 1, @d.size
    assert_equal @alice, @d.head
    assert_equal @alice, @d.tail
  end

  def test_remove_end_complains_when_empty
    assert_raises EmptyListError do
      @d.remove_end
    end
  end

  def test_remove_before_works_when_node_present
    @d.insert_front @bob
    @d.insert_front @alice
    result = @d.remove_before @bob
    assert_equal @alice, result
    assert_equal 1, @d.size
    assert_equal @bob, @d.head
  end

  def test_remove_before_complains_when_no_node
    @d.insert_front @bob
    assert_raises NoNodeError do
      @d.remove_before @bob
    end
  end

  def test_remove_after_works_when_node_present
    @d.insert_front @bob
    @d.insert_after @bob, @claire
    result = @d.remove_after @bob
    assert_equal @claire, result
    assert_equal 1, @d.size
    assert_equal @bob, @d.tail
  end

  def test_remove_after_complains_when_no_node
    @d.insert_front @bob
    assert_raises NoNodeError do
      @d.remove_after @bob
    end
  end
end