require 'minitest/autorun'

# Implementation of Undirected Graph Data Structure
class UndirectedGraph
  attr_reader :edges, :vertices

  def initialize
    @edges = Set.new
    @vertices = Set.new
  end

  def <<(value)
    @vertices << value
  end

  alias add_vertex :<<

  def connect(v1, v2)
    raise ArgumentError, "#{v1} or #{v2} isn't a vertex" unless (Set.new([v1, v2]) <= @vertices)

    @edges << Set.new([v1, v2])
  end

  def disconnect(v1, v2)
    @edges.delete Set.new([v1, v2])
  end

  def adjacent?(v1, v2)
    @edges.include? Set.new([v1, v2])
  end

  def edges_on(vertex)
    @edges.select { |edge| edge.include? vertex }
  end

end

# Test cases for undirected graph
class UndirectedGraphTest < Minitest::Test
  def setup
    @ug = UndirectedGraph.new
  end

  def test_can_add_nodes_to_graph
    @ug.add_vertex 4
    assert_includes @ug.vertices, 4
  end

  def test_shovel_operator_also_adds_vertex
    @ug << 4
    assert_includes @ug.vertices, 4
  end

  def test_you_can_connect_two_vertices
    @ug << 3
    @ug << 4
    @ug.connect 3, 4
    expected = Set.new << Set.new([3, 4])
    assert_equal expected, @ug.edges
  end

  def test_you_can_disconnect_two_vertices
    @ug << 3
    @ug << 4
    @ug.connect 3, 4
    @ug.disconnect 3, 4
    refute @ug.edges.include? Set.new([3, 4])
  end

  def test_connected_returns_true_if_two_vertices_are_connected
    @ug << 3
    @ug << 4
    @ug.connect 3, 4
    assert @ug.adjacent?(3, 4)
  end

  def test_connected_returns_false_if_not_connected
    @ug << 3
    @ug << 4
    refute @ug.adjacent?(3, 4)
  end

  def test_edges_on_returns_all_connections_to_vertex
    @ug << 1
    expected = []
    (2..10).each do |i|
      @ug << i
      @ug.connect 1, i
      expected << Set.new([1, i])
    end
    assert_equal expected, @ug.edges_on(1)
  end
    
end
