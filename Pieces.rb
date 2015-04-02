require 'byebug'

class Array
  def row
    self.first
  end

  def col
    self.last
  end
end

class Piece
  attr_accessor :position, :color

  def initialize(color, pos, board)
    @color = color
    @position = pos
    @board = board
    @king = false
  end

  def perform_side(user_move)
    possible_moves = move_diffs
    if possible_moves.include?(user_move) && @board[user_move].nil?
      @position == user_move

      true
    else

      false
    end
  end

  def perform_jump(user_move)
    # debugger
    possible_moves = move_diffs
    row_direction = user_move.row <=> @position.row
    col_direction = user_move.col <=> @position.col
    over_location = [@position.row + row_direction, @position.col + col_direction]
    if possible_moves.include?(over_location) &&
      @board[over_location].color != @color && @board[user_move].nil?

      true
    else

      false
    end
  end


  def maybe_promote?
    return true if @color == :red && @position.row == 0
    return true if @color == :black && @position.row == 7
    false
  end

  def promote
    @king = true
  end

  def move_diffs
    possible_moves = []

    if @king
      possible_moves = king_moves
    elsif @color == :black
      possible_moves << [@position.row + 1 , @position.col + 1]
      possible_moves << [@position.row + 1 , @position.col - 1]
    else
      possible_moves << [@position.row - 1 , @position.col + 1]
      possible_moves << [@position.row - 1 , @position.col - 1]
    end

    possible_moves = remove_offboard_moves(possible_moves)
  end
  
  def king_moves
    possible_moves = []
    possible_moves << [@position.row - 1 , @position.col + 1]
    possible_moves << [@position.row - 1 , @position.col - 1]
    possible_moves << [@position.row + 1 , @position.col + 1]
    possible_moves << [@position.row + 1 , @position.col - 1]
  end

  def remove_offboard_moves(all_moves)
    all_moves.select do |move|
      move.row.between?(0,7) && move.col.between?(0,7)
    end
  end

  def render_image
    @color == :red ? 'r' : 'b'
  end

end
