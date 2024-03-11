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
      8.times { |y| arr << Node.new(x, y) }
    end
    @nodes = arr # [[node(x, y)], [node(x, y)], [node(x, y)]...]
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
        @nodes.find { |node| node.x == move[0] && node.y == move[1] } # Add neighbor nodes
      end
    end
  end

  def shortest_path(source, goal) # Find shortest path use modified version of Breadth-First Search
    visited = []
    queue = []
    path = {} # Store parent of node

    source = @nodes.find { |node| node.x == source[0] && node.y == source[1] } # Return source node
    goal = @nodes.find { |node| node.x == goal[0] && node.y == goal[1] } # Return goal node
    queue << source
    visited << source

    until queue.nil?
      curr = queue.shift # Take out First value of queue
      return print_path(path, source, goal) if curr == goal

      curr.neighbor.each do |neighbor| # Visit all neightbors
        next if visited.include?(neighbor)

        queue << neighbor
        visited << neighbor
        path[neighbor] = curr # Store node and curr as parent of node
      end
    end
  end

  def print_path(path, source, goal)
    curr = goal

    shortest_path = []

    until curr == source # Trace back path from last node (goal) through parent node
      shortest_path.unshift([curr.x, curr.y])
      curr = path[curr]
    end
    shortest_path.unshift([source.x, source.y])
  end

  def knight_move(source, goal)
    path = shortest_path(source, goal)
    puts "You made #{path.length - 1} moves! Your path:"
    path.each { |item| p item }
  end
end

game = Knight.new

game.knight_move([0, 0], [7, 7])
