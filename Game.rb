require './board'

class Game
  def initialize
    @game = Board.new
    @turn = :red
    create_board_hash
  end

  def toggle_turn
    @turn == :red ? @turn = :black : @turn = :red
  end

  def create_board_hash
    @parser = Hash.new
    columns = %w(a b c d e f g h)

    8.times do |row_idx|
      8.times do |col_idx|
        @parser[columns[col_idx] + (8 - row_idx).to_s] = [row_idx, col_idx]
      end
    end

    nil
  end

  def play
    puts "Time to play Checkers!"

    until @game.won?
      @game.render
      moves = get_move
      start = moves[0]
      if @game[start].color != @turn
        puts "Please Pick Your Own Piece"
        next
      end
      @game[start].perform_moves!(moves.drop(1))
      toggle_turn
    end
    puts "Winner is #{@game.winner}"

  end

  def get_move
    moves = []
    puts "#{@turn} Turn: Please give me your moves.  Separate by a , (ex. b6,a5,b7)"
    move_seq = gets.chomp.downcase.split(",")
    move_seq.each {|move| moves << @parser[move] }
  
    moves
  end


end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
