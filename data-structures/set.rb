require 'minitest/autorun'
require_relative 'hash_table'

# Implements a mathematical set
# Made some changes to HashTable to use ruby's built-in hash method
class MySet < HashTable
  def initialize(initial_size = 8)
    @size = initial_size
    hf = Proc.new { |item| item.hash % @size }
    super(hf, @size)
  end

  def store(val)
    begin
      super(val)
    rescue CollisionError
    end

    if count == @size
      @slots += Array.new(@size)
      @size *= 2
    end

    self  # Return self for useful << shovel chaining
  end

  alias_method :<<, :store

  def count
    @slots.count { |a| not a.nil? }
  end

  def ==(other)
    return false unless count == other.count
    to_a.all? { |item| other.include?(item) }
  end

  # --- MySet methods
  def intersect(other)
    items = to_a.select { |item| other.include?(item) && !item.nil? }
    combined = MySet.new
    items.each { |i| combined.store(i) }
    combined
  end

  alias_method :&, :intersect

  def union(other)
    combined = MySet.new
    (to_a + other.to_a).each { |item| combined.store(item) }
    combined
  end

  alias_method :|, :union

  def difference(other)
    combined = MySet.new
    to_a.each { |item| combined.store(item) unless other.include?(item) }
    combined
  end

  alias_method :-, :difference

  def symmetric_difference(other)
    (self - other) | (other - self)
  end

  alias_method :^, :symmetric_difference

end

class MySetTest < Minitest::Test
  def setup
    @a = MySet.new
    @a << 1 << 2 << 3
    @b = MySet.new
    @b << 2 << 3 << 4
  end

  def test_two_Mysets_that_are_the_same_are_equal
    c = MySet.new << 1 << 2 << 3
    assert_equal c, @a
  end

  def test_can_count_values
    assert_equal 3, @a.count
  end

  def test_intersect
    result = @a & @b
    expected = MySet.new << 2 << 3
    assert_equal expected, result
  end

  def test_union
    result = @a | @b
    expected = MySet.new << 1 << 2 << 3 << 4
    assert_equal expected, result
  end

  def test_difference
    result = @a - @b
    expected = MySet.new << 1
    assert_equal expected, result
  end

  def test_symmetric_difference
    result = @a ^ @b
    expected = MySet.new << 1 << 4
    assert_equal expected, result
  end
end


