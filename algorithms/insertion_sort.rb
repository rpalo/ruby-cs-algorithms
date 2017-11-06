require 'minitest/autorun'

def insertion_sort(items, verbose = false)
  (1...items.length).each do |unsorted_index|
    value = items[unsorted_index]
    searching_index = unsorted_index - 1
    while searching_index >= 0 && items[searching_index] > value
      items[searching_index], items[searching_index + 1] =
        items[searching_index + 1], items[searching_index]
      searching_index -= 1
      p items if verbose
    end
    p items if verbose
  end
  items
end

class InsertionSortTest < Minitest::Test
  def test_can_sort_list
    result = insertion_sort([4, 3, 2, 5, 1])
    expected = [1, 2, 3, 4, 5]
    assert_equal expected, result
  end

  def test_can_sort_list_with_doubles
    result = insertion_sort([4, 3, 2, 5, 5, 5, 1])
    expected = [1, 2, 3, 4, 5, 5, 5]
    assert_equal expected, result
  end

  def test_can_sort_one_item
    result = insertion_sort([1])
    expected = [1]
    assert_equal expected, result
  end

  def test_can_sort_no_items
    result = insertion_sort([])
    expected = []
    assert_equal expected, result
  end
end
