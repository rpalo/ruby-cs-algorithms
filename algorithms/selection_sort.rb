require 'minitest/autorun'

def selection_sort(items, verbose = false)
  (0...items.length).each do |i|
    smallest_value = items[i]
    smallest_index = i
    (i...items.length).each do |ii|
      if items[ii] < smallest_value
        smallest_value = items[ii]
        smallest_index = ii
      end
    end
    items[i], items[smallest_index] = smallest_value, items[i]
    puts "[#{items.join(', ')}]" if verbose
  end

  items
end

class SelectionSortTest < Minitest::Test
  def test_can_sort_list
    result = selection_sort([4, 3, 2, 5, 1])
    expected = [1, 2, 3, 4, 5]
    assert_equal expected, result
  end

  def test_can_sort_list_with_doubles
    result = selection_sort([4, 3, 2, 5, 5, 5, 1])
    expected = [1, 2, 3, 4, 5, 5, 5]
    assert_equal expected, result
  end

  def test_can_sort_one_item
    result = selection_sort([1])
    expected = [1]
    assert_equal expected, result
  end

  def test_can_sort_no_items
    result = selection_sort([])
    expected = []
    assert_equal expected, result
  end
end