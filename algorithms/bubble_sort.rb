require 'minitest/autorun'

def bubble_sort(items, verbose = false)
  (items.length - 1).times do
    swapped = false
    (0...items.length - 1).each do |i|
      if items[i] > items[i + 1]
        items[i], items[i + 1] = items[i + 1], items[i]
        swapped = true
      end
    end
    return items unless swapped  # Break out early if no changes
  end
  return items
end


class BubbleSortTest < Minitest::Test
  def test_can_sort_list
    result = bubble_sort([4, 3, 2, 5, 1])
    expected = [1, 2, 3, 4, 5]
    assert_equal expected, result
  end

  def test_can_sort_list_with_doubles
    result = bubble_sort([4, 3, 2, 5, 5, 5, 1])
    expected = [1, 2, 3, 4, 5, 5, 5]
    assert_equal expected, result
  end

  def test_can_sort_one_item
    result = bubble_sort([1])
    expected = [1]
    assert_equal expected, result
  end

  def test_can_sort_no_items
    result = bubble_sort([])
    expected = []
    assert_equal expected, result
  end
end