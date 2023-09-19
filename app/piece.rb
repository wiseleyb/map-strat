# represents a board piece.
# Players have many pieces
# Civilizations have many pieces
class Piece
  attr_accessor :x,
                :y,
                :piece_type,
                :moves

  def initialize
    @x = 3
    @y = 2
    @piece_type = 'X'
    @moves = 2
  end

  def draw(args)
    label = {
      x: Utils.map_grid_x(x) + PIECE_PADDING_X,
      y: Utils.map_grid_y(y) - PIECE_PADDING_Y,
      text: piece_type,
      size_enum: 10,
    }
    args.outputs.labels << label
  end
end
