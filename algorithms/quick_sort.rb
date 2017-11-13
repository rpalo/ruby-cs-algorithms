require 'minitest/autorun'

def quick_sort(items)
  # Base case: a list of one (or zero) is sorted
  return items if items.length <= 1

  pivot = items.length - 1
  pivot_item = items[pivot]

  # Run swapping to sort to either side of pivot
  # This while loop is the magic of quicksort
  lower = 0
  upper = pivot - 1
  while lower <= upper
    while items[lower] < pivot_item
      lower += 1
    end

    while items[upper] > pivot_item
      upper -= 1
    end

    # If lower is still less than upper, but we got through
    # the above two while loops, lower is stuck on something
    # that is >= the pivot, and upper is stuck on something
    # that is <= the pivot.  So, we swaparooney!
    if lower <= upper
      items[lower], items[upper] = items[upper], items[lower]
      lower += 1
      upper -= 1
    end
  end

  # Swap the pivot into the middle, where lower is pointing.
  items[lower], items[pivot] = items[pivot], items[lower]

  # Sort either side recursively
  left = items[0...lower]
  right = items[(lower+1)...items.length]
  left = quick_sort(left)
  right = quick_sort(right)

  # Merge together
  result = left + [pivot_item] + right
  # p result
end


class MergeSortTest < Minitest::Test
  def test_can_sort_list
    result = quick_sort([4, 3, 2, 5, 1])
    expected = [1, 2, 3, 4, 5]
    assert_equal expected, result
  end

  def test_can_sort_list_with_doubles
    result = quick_sort([4, 3, 2, 5, 5, 5, 1])
    expected = [1, 2, 3, 4, 5, 5, 5]
    assert_equal expected, result
  end

  def test_can_sort_one_item
    result = quick_sort([1])
    expected = [1]
    assert_equal expected, result
  end

  def test_can_sort_no_items
    result = quick_sort([])
    expected = []
    assert_equal expected, result
  end

  def test_can_sort_a_lot_of_items
    result = quick_sort([53,88,12,87,39,58,55,10,6,89,46,79,38,49,42,45,2,56,81,21,25,92,28,85,59,22,66,17,33,4,8,23,36,71,93,43,13,61,69,78,14,98,65,68,27,30,64,63,67,82,40,74,86,3,20,7,5,83,35,60,15,51,76,19,72,48,91,18,84,80,24,62,77,9,11,52,75,41,96,37,47,70,44,50,99,57,97,34,90,1,95,29,73,100,31,54,26,32,16,94])
    expected = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100]
    assert_equal expected, result
  end
end
