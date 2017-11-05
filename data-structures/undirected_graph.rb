require 'minitest/autorun'
require 'set'

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

  def degree(vertex)
    raise ArgumentError, "#{vertex} isn't in this graph" unless @vertices.include?(vertex)

    edges_on(vertex).count
  end

  def degrees
    @vertices.to_a.map { |vertex| degree(vertex) }
  end

  def all_connected?
    ! degrees.any? { |deg| deg.zero? }
  end

  def eulerian_path?
    return false unless all_connected?
    odds = degrees.count { |deg| deg.odd? }
    odds == 2 or odds == 4
  end

  def eulerian_cycle?
    return false unless all_connected?
    odds = degrees.count { |deg| deg.odd? }
    odds == 0
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

  def test_degree_counts_adjacent_vertices
    @ug << 1
    @ug << 2
    @ug << 3
    @ug.connect(1, 2)
    assert_equal 1, @ug.degree(1)
    @ug.connect(1, 3)
    assert_equal 2, @ug.degree(1)
  end

  def test_degrees_lists_degree_of_each_element
    @ug << 1
    @ug << 2
    @ug << 3
    @ug.connect(1, 2)
    assert_equal Set.new(@ug.degrees), Set.new([1, 1, 0])
    @ug.connect(1, 3)
    assert_equal Set.new(@ug.degrees), Set.new([1, 2, 1])
  end

  def test_all_connected_when_true
    @ug << 1
    @ug << 2
    @ug << 3
    @ug.connect 1, 2
    @ug.connect 1, 3
    assert @ug.all_connected?
  end

  def test_all_connected_when_false
    @ug << 1
    @ug << 2
    @ug << 3
    @ug.connect 1, 2
    refute @ug.all_connected?
  end

  def test_eulerian_path_when_true
    @ug << 1
    @ug << 2
    @ug << 3
    @ug << 4
    @ug.connect 1, 2
    @ug.connect 2, 3
    @ug.connect 3, 4
    assert @ug.eulerian_path?
  end

  def test_eulerian_path_when_not_all_connected
    @ug << 1
    @ug << 2
    @ug << 3
    @ug.connect 1, 2
    refute @ug.eulerian_path?
  end

  def test_konigsberg
    @ug << :a
    @ug << :A
    @ug << :b
    @ug << :c
    @ug << :d
    @ug << :D
    @ug << :f
    @ug << :g
    @ug.connect :a, :b
    @ug.connect :a, :A
    @ug.connect :A, :c
    @ug.connect :A, :d
    @ug.connect :c, :d
    @ug.connect :A, :D
    @ug.connect :D, :f
    @ug.connect :D, :g
    @ug.connect :d, :g
    @ug.connect :c, :g
    @ug.connect :a, :f
    @ug.connect :b, :f
    refute @ug.eulerian_path?
  end

  def test_eulerian_cycle_when_true
    @ug << :A
    @ug << :B
    @ug << :C
    @ug << :D
    @ug << :E
    @ug.connect :A, :B
    @ug.connect :A, :C
    @ug.connect :B, :C
    @ug.connect :A, :D
    @ug.connect :A, :E
    @ug.connect :D, :E
    assert @ug.eulerian_cycle?
  end

  def test_eulerian_cycle_when_false
    @ug << :A
    @ug << :B
    @ug << :C
    @ug << :D
    @ug << :E
    @ug.connect :A, :B
    @ug.connect :A, :C
    @ug.connect :A, :D
    @ug.connect :B, :C
    @ug.connect :B, :D
    @ug.connect :D, :E
    refute @ug.eulerian_cycle?
  end
end
