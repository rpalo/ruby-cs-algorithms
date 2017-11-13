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

    p items if verbose
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

  def test_can_sort_a_lot_of_items
    result = bubble_sort([53,88,12,87,39,58,55,10,6,89,46,79,38,49,42,45,2,56,81,21,25,92,28,85,59,22,66,17,33,4,8,23,36,71,93,43,13,61,69,78,14,98,65,68,27,30,64,63,67,82,40,74,86,3,20,7,5,83,35,60,15,51,76,19,72,48,91,18,84,80,24,62,77,9,11,52,75,41,96,37,47,70,44,50,99,57,97,34,90,1,95,29,73,100,31,54,26,32,16,94])
    expected = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100]
    assert_equal expected, result
  end
end