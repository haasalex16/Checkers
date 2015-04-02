class Array
  def row
    self.first
  end

  def col
    self.last
  end
end


class Piece
  attr_accessor :position

  def initialize(color, pos ,board)
    @king = false
    @color = color
    @board = board
    @position = pos

  end

  def perform_side


  end

  def attack?


  end


  def perform_jump


  end


  def maybe_promote?
    return true if @color == :red && @position.row == 7
    return true if @color == :black && @position.row == 0
    false
  end

  def promote
    @king = true
  end

  def move_diffs
    @possible_moves = []
    if @color == :red
      @possible_moves << [@position.row + 1 , @position.col + 1]
      @possible_moves << [@position.row + 1 , @position.col - 1]
    else
      @possible_moves << [@position.row - 1 , @position.col + 1]
      @possible_moves << [@position.row - 1 , @position.col - 1]
    end

    if @king && @color == :red
      @possible_moves << [@position.row - 1 , @position.col + 1]
      @possible_moves << [@position.row - 1 , @position.col - 1]
    elsif @king && @color == :black
      @possible_moves << [@position.row + 1 , @position.col + 1]
      @possible_moves << [@position.row + 1 , @position.col - 1]
    end
    
    @possible_moves = remove_offboard_moves(@possible_moves)
  end

  def remove_offboard_moves(all_moves)
    all_moves.select do |move|
      move.row.between?(0,7) && move.col.between?(0,7)
    end
  end



end
