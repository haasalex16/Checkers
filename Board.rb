require './Pieces'

#BLACK on TOP
#RED on BOTTOM

class Board
  EVEN_ROW = [nil, true, nil, true, nil, true, nil, true]
  ODD_ROW = [true, nil, true, nil,true, nil, true, nil]

  def initialize
    @board = Array.new(8) {Array.new(8)}
    build_board
  end

  def build_board
    @board.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        if (row_idx + col_idx).odd? && row_idx < 3
          @board[row_idx][col_idx] = Piece.new(:black, [row_idx,col_idx],nil)
        elsif (row_idx + col_idx).odd? && row_idx > 4
          @board[row_idx][col_idx] = Piece.new(:black, [row_idx,col_idx],nil)
        end
      end
    end
  end





end
