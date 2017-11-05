require 'minitest/autorun'
require_relative '../data-structures/undirected_graph'

# Note that DFS is essentially the same as BFS, but uses a stack
# where BFS uses a queue

def depth_first_search(graph, start_node, target)
  processed_nodes = []
  pending_nodes = [start_node]

  # Set up the hash table of nodes to neighbors
  # Not really necessarily, but possibly a lot more performant
  # for bigger graphs
  neighbors = Hash.new { |h, k| h[k] = [] }
  graph.edges.each do |edge|
    a, b = edge.to_a
    neighbors[a] << b
    neighbors[b] << a
  end

  # Run the search
  until pending_nodes.empty?
    current = pending_nodes.pop
    return current if current == target
    neighbors[current].each do |neighbor|
      unless processed_nodes.include?(neighbor) or pending_nodes.include?(neighbor)
        pending_nodes << neighbor
      end
    end

    processed_nodes << current
  end

  # We've searched everything.
  # If we haven't found the target by now, it's not in here
  return false

end

class DfsTest < Minitest::Test

  #     3
  #     |
  # 1 - 2 - 4   9
  #     |       | 
  #     5 - 6 - 7 - 8

  def setup
    @graph = UndirectedGraph.new
    @graph << 1 << 2 << 3 << 4 << 5 << 6 << 7 << 8 << 9
    @graph.connect(1, 2)
    @graph.connect(2, 3)
    @graph.connect(2, 5)
    @graph.connect(2, 4)
    @graph.connect(5, 6)
    @graph.connect(6, 7)
    @graph.connect(7, 8)
    @graph.connect(7, 9)
  end

  def test_can_find_node_in_graph
    result = depth_first_search(@graph, 1, 9)
    assert_equal 9, result
  end

  def test_doesnt_find_node_not_in_graph
    result = depth_first_search(@graph, 1, 25)
    refute result
  end

  def test_can_still_find_node_in_graph_with_different_start_point
    result = depth_first_search(@graph, 7, 9)
    assert_equal 9, result
  end
end