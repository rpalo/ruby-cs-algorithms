require 'minitest/autorun'

# Binary Search Tree Data Structure
class BinarySearchTree
  attr_reader :left, :right, :data

  def initialize
    @data = nil
    @left = nil
    @right = nil
  end

  def insert(item)
    if @data.nil?
      @data = item
      @left = BinarySearchTree.new
      @right = BinarySearchTree.new
    else
      item > @data ? @right.insert(item) : @left.insert(item)
    end
  end

  def search(item)
    return true if @data == item
    if item > @data
      return @right.data && @right.search(item)
    else
      return @left.data && @left.search(item)
    end
  end
end

# Test cases for binary search tree
class BinarySearchTreeTest < Minitest::Test
  def setup
    @bst = BinarySearchTree.new
    @bst.insert 42
  end

  def test_single_node_insert
    @bst.insert(30)
    assert_equal 30, @bst.left.data
    @bst.insert(50)
    assert_equal 50, @bst.right.data
  end

  def test_node_a_few_layers_deep
    @bst.insert(30)
    @bst.insert(20)
    @bst.insert(10)
    assert_equal 10, @bst.left.left.left.data
  end

  def test_search_one_layer
    assert @bst.search(42)
    refute @bst.search(9)
  end

  def test_search_a_few_layers_deep
    @bst.insert(30)
    @bst.insert(35)
    @bst.insert(37)
    assert @bst.search(37)
    refute @bst.search(12)
  end
end
