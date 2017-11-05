require 'minitest/autorun'
require_relative 'hash_table'
require_relative 'linked_list'

# A hash table that lets the user provide a hashing function
# Hash function *should* return an integer that is 0 <= i < size
# Stores items as linked lists, so upon collision, adds to chain

class ChainingHashTable < HashTable
  def initialize(hash_function, size)
    super(hash_function, size)
    @slots = Array.new(size) { LinkedList.new }
  end

  def store(val)
    slot_index = @hash_function.call(val)
    @slots[slot_index].insert_front(Node.new(val))
  end

  def include?(val)
    @slots.any? { |chain| chain.include? val }
  end
end

class ChainingHashTableTest < Minitest::Test

  def setup
    hf = Proc.new { |item| item.length % 10 }
    @h = ChainingHashTable.new(hf, 10)
  end

  def test_can_store_values
    @h.store('banana')
    assert @h.include?('banana')
  end

  def test_knows_if_value_isnt_in_table
    @h.store('banana')
    refute @h.include?('soup')
  end

  def test_can_store_in_chain_when_hash_function_collides
    @h.store('fish')
    @h.store('soup')
    assert @h.include?('fish')
    assert @h.include?('soup')
  end

end

