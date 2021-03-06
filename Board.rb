require './Pieces'

#BLACK on TOP
#RED on BOTTOM

class Board
  EVEN_ROW = [nil, true, nil, true, nil, true, nil, true]
  ODD_ROW = [true, nil, true, nil,true, nil, true, nil]

  attr_accessor :board, :turn

  def initialize(fill_board = true)
    @board = Array.new(8) {Array.new(8)}
    build_board if fill_board
  end

  def [](pos)
    i , j = pos
    @board[i][j]
  end

  def []=(pos, piece)
    i , j = pos
    @board[i][j] = piece
  end

  def build_board
    @board.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        if (row_idx + col_idx).odd? && row_idx < 3
          @board[row_idx][col_idx] = Piece.new(:black, [row_idx,col_idx], self)
        elsif (row_idx + col_idx).odd? && row_idx > 4
          @board[row_idx][col_idx] = Piece.new(:red, [row_idx,col_idx], self)
        end
      end
    end
  end

  def render
    puts "  A|B|C|D|E|F|G|H"
    @board.each_with_index do |row,idx|
      render_array = [8-idx]
      row.each do |cell|
        cell.nil? ? render_array << "_" : render_array << cell.render_image
      end
      puts render_array.join("|")
    end

    nil
  end

  def move_piece(from_pos, to_pos)
    piece = self[from_pos]

    piece.position = to_pos
    self[to_pos] = piece
    self[from_pos] = nil
  end

  def checkers
    @board.flatten.compact
  end

  def dup_board
    new_board = Board.new(false)

    checkers.each do |checker|
      new_board[checker.position] = Piece.new(checker.color, checker.position, new_board)
    end

    new_board
  end

  def counts
    black_count = 0
    red_count = 0
    checkers.each do |checker|
      black_count += 1 if checker.color == :black
      red_count += 1 if checker.color == :red
    end

    [black_count, red_count]
  end

  def won?
    counts.include?(0)
  end

  def winner
    counts.first == 0 ? "BLACK" : "RED"
  end

end
