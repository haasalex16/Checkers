class Piece


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

  def upgrade
    @king = true
  end

  def move_diffs
    @possible_moves = []
    if @color == :white
      @possible_moves << [@position.first + 1 , @position.last + 1]
      @possible_moves << [@position.first + 1 , @position.last - 1]
    else
      @possible_moves << [@position.first - 1 , @position.last + 1]
      @possible_moves << [@position.first - 1 , @position.last - 1]
    end

    if @king && @color == :white
      @possible_moves << [@position.first - 1 , @position.last + 1]
      @possible_moves << [@position.first - 1 , @position.last - 1]
    elsif @king && @color == :black
      @possible_moves << [@position.first + 1 , @position.last + 1]
      @possible_moves << [@position.first + 1 , @position.last - 1]
    end
    @possible_moves
  end


end
