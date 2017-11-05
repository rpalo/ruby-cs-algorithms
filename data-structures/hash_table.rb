require 'minitest/autorun'

class CollisionError < StandardError; end


class HashTable
  def initialize(hash_function, size)
    @hash_function = hash_function
    @slots = Array.new size
  end

  def store(val)
    slot_index = @hash_function.call(val)
    raise CollisionError if @slots[slot_index] # Occupado, amigo
    @slots[slot_index] = val
  end

  def include?(value)
    @slots.include?(value)
  end

end

class HashTableTest < Minitest::Test

  def setup
    hf = Proc.new { |item| item.length % 10 }
    @h = HashTable.new(hf, 10)
  end

  def test_can_store_values
    @h.store('banana')
    assert @h.include?('banana')
  end

  def test_knows_if_value_isnt_in_table
    @h.store('banana')
    refute @h.include?('soup')
  end

  def test_complains_when_hash_function_collides
    @h.store('fish')
    assert_raises CollisionError do
      @h.store('soup')
    end
  end

end