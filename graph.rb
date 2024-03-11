class Node
  attr_accessor :x, :y, :neighbor

  def initialize(x, y)
    @x = x
    @y = y
    @neighbor = []
  end

  def to_s
    "[#{node.x}, #{node.y}]"
  end
end

class Knight
  def initialize
    @nodes = build_graph
  end

  def build_graph(arr = [])
    8.times do |x|
      8.times { |y| arr << Node.new(x, y)}
    end
    @nodes = arr
    add_neighbor
  end

  def add_neighbor
    @nodes.each do |node|
      x = node.x
      y = node.y

      moves = [[x - 2, y + 1], [x - 2, y - 1], [x - 1, y + 2], [x - 1, y - 2], [x + 1, y + 2], [x + 1, y - 2],
               [x + 2, y + 1], [x + 2, y - 1]]

      moves.keep_if { |move| (0..7).include?(move[0]) && (0..7).include?(move[1]) }

      node.neighbor = moves.map do |move|
        @nodes.find { |node| node.x == move[0] && node.y == move[1] }
      end
    end
  end
end