require 'minitest/autorun'

require_relative 'undirected_graph'

# Directed Graph Implementation
class DirectedGraph < UndirectedGraph

  def connect(v1, v2)
    raise ArgumentError,
      "#{v1} or #{v2} isn't in this graph" unless (Set.new([v1, v2]) <= @vertices)
    
    @edges << [v1, v2]
  end

  def disconnect(v1, v2)
    @edges.delete [v1, v2]
  end

  def connected?(v1, v2)
    @edges.include? [v1, v2]
  end
end

# Test Cases for Directed Graph
class DirectedGraphTest < Minitest::Test
  def setup
    @dg = DirectedGraph.new
  end

  def test_can_add_nodes_to_graph
    @dg.add_vertex 4
    assert_includes @dg.vertices, 4
  end

  def test_shovel_operator_also_adds_vertex
    @dg << 4
    assert_includes @dg.vertices, 4
  end

  def test_you_can_connect_two_vertices
    @dg << 3
    @dg << 4
    @dg.connect 3, 4
    expected = Set.new << [3, 4]
    assert_equal expected, @dg.edges
  end

  def test_you_can_disconnect_two_vertices
    @dg << 3
    @dg << 4
    @dg.connect 3, 4
    @dg.disconnect 3, 4
    refute @dg.edges.include? [3, 4]
  end

  def test_connected_returns_true_if_two_vertices_are_connected
    @dg << 3
    @dg << 4
    @dg.connect 3, 4
    assert @dg.connected?(3, 4)
  end

  def test_connected_returns_false_if_not_connected
    @dg << 3
    @dg << 4
    refute @dg.connected?(3, 4)
  end

  def test_connected_returns_false_if_nodes_are_backwards
    @dg << 3
    @dg << 4
    @dg.connect(3, 4)
    refute @dg.connected?(4, 3)
  end

  def test_edges_on_returns_all_connections_to_vertex
    @dg << 1
    expected = []
    (2..10).each do |i|
      @dg << i
      @dg.connect 1, i
      expected << [1, i]
    end
    assert_equal expected, @dg.edges_on(1)
  end
end
    
