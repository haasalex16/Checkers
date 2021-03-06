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
  attr_accessor :position, :color, :king

  def initialize(color, pos, board)
    @color = color
    @position = pos
    @board = board
    @king = false
  end

  def perform_slide(user_move)

    if slide_valid?(user_move)
      @board.move_piece(@position, user_move)

      true
    else

      false
    end
  end

  def slide_valid?(user_move)

    if possible_moves.include?(user_move) && @board[user_move].nil?

      true
    else

      false
    end
  end

  def perform_jump(user_move)

    row_direction = user_move.row <=> @position.row
    col_direction = user_move.col <=> @position.col
    over_location = [@position.row + row_direction, @position.col + col_direction]
    # debugger
    if jump_valid?(user_move, over_location)
      @board[over_location] = nil
      @board.move_piece(@position, user_move)
      true
    else

      false
    end
  end

  def jump_valid?(user_move, over_location)
    return false if @board[over_location].nil?

    if possible_moves.include?(over_location) &&
      @board[over_location].color != @color && @board[user_move].nil? #CHECKK

      true
    else

      false
    end
  end

  def promote?
    return true if @color == :red && @position.row == 0
    return true if @color == :black && @position.row == 7
    false
  end

  def promote
    @king = true
  end

  def move_diffs
    black_moves =   [[1, 1],  [1, -1]]
    red_moves =     [[-1, 1], [-1, -1]]

    if @king
      black_moves.concat(red_moves)
    elsif @color == :black
      black_moves
    else
      red_moves
    end
  end

  def possible_moves
    possible_moves = []

    move_diffs.each do |(dy, dx)|
      possible_moves << [@position.row + dy, @position.col + dx]
    end

    possible_moves = remove_invalid_moves(possible_moves)
  end

  def remove_invalid_moves(all_moves)

    on_board = all_moves.select do |move|
      move.row.between?(0,7) && move.col.between?(0,7)
    end

    on_board.select do |move|
      @board[move].nil? || @board[move].color != @color
    end
  end

  def render_image
    if @king
      @color == :red ? "\u2654" : "\u265A"
    else
      @color == :red ? "\u25CE" : "\u25C9"
    end
  end

  # =>  start       finish
  # [[2,3], [3,4], [4,3]]
  def valid_move_seq?(move_seq)
    test_board = @board.dup_board
    # debugger
    if test_board[@position].perform_moves!(move_seq)
      return true
    else
      raise InvalidMoveError
    end
  end

  def perform_moves!(move_seq)

    if move_seq.count == 1
      return true if perform_slide(move_seq.first)
      if perform_jump(move_seq.first)
        return true
      else
        return false
      end
    else
      move_seq.each do |move|
        return false unless perform_jump(move)
        promote if promote?
      end
    end

    promote if promote?

    true
  end


end
