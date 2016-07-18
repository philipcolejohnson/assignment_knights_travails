Node = Struct.new(:x, :y, :depth, :children, :parent)

class ChessTree
  attr_reader :size, :max_depth, :start, :root 
  POSSIBLE_MOVES = [[1,2],[2,1], [-1, -2], [-2, -1],
                    [-1, 2], [2, -1], [1,-2],[-2, 1]]

  def initialize(size, max_depth, start = [0, 0])
    @total_children = 0
    @root = nil
    @size = size
    @max_depth = max_depth
    @start = start
  end

  def ask_start
    puts "Where do you want to start?(pick an x, y coordinate)"
    @start = gets.chomp.split(",").map(&:to_i)
  end

  def make_root
    @root = Node.new(@start[0], @start[1], 0, [], nil)
  end

  def create_tree
    make_root
    make_children(@root)
    self
  end

  def make_children(node)
    POSSIBLE_MOVES.each do |move|
      if (node.x + move[0] < size && node.y + move[1] < size) &&
          (node.x + move[0] >= 0 && node.y + move[1] >= 0)
        child = Node.new(node.x + move[0], node.y + move[1], node.depth + 1, [], node)
        node.children << child
        @total_children += 1
        make_children(child) unless child.depth == @max_depth
      else
        next
      end
    end
  end

  def check_target?(child)
    child.x == @finish[0] && child.y = @finish[1]
  end


  def insert(x, y)
    if @root.nil?
      add_root(x, y)
    else
      node = nodify(x, y)
      add_node(node)
    end
  end
  
  def nodify(x, y)
    node.new(x, y, nil, [])
  end

  def add_root(x, y)
    @root = nodify(x, y, 0, [])
  end

  def add_node(node)
    current_node = @root
    parent = nil
    until current_node.nil?
      parent = current_node
      if node.value < current_node.value
        current_node = current_node.left
      else
        current_node = current_node.right
      end
    end

    node.value < parent.value ? parent.left = node : parent.right = node
  end
end