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

  def initialize(color, pos, board)
    @color = color
    @position = pos
    @board = board
    @king = false
  end

  def perform_side(user_move)
    possible_moves = move_diffs
    if possible_moves.include?(user_move) &&
      board[user_move.col][user_move.row].nil?
      @position == user_move
      true
    else
      false
    end
  end

  def attack?


  end

  def move(user_move)
    case @position.row <=> user_move.row
    when 1


    when -1


    end

  end


  def perform_jump


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

    if @color == :black
      possible_moves << [@position.row + 1 , @position.col + 1]
      possible_moves << [@position.row + 1 , @position.col - 1]
    else
      possible_moves << [@position.row - 1 , @position.col + 1]
      possible_moves << [@position.row - 1 , @position.col - 1]
    end

    if @king && @color == :black
      possible_moves << [@position.row - 1 , @position.col + 1]
      possible_moves << [@position.row - 1 , @position.col - 1]
    elsif @king && @color == :red
      possible_moves << [@position.row + 1 , @position.col + 1]
      possible_moves << [@position.row + 1 , @position.col - 1]
    end

    possible_moves = remove_offboard_moves(possible_moves)
  end

  def remove_offboard_moves(all_moves)
    all_moves.select do |move|
      move.row.between?(0,7) && move.col.between?(0,7)
    end
  end



end
