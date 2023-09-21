# represents a board piece.
# Players have many pieces
# Civilizations have many pieces
class Piece
  attr_accessor :x,
                :y,
                :piece_type,
                :moves

  def initialize(x, y, piece_type = 'X')
    @x = x
    @y = y
    @piece_type = piece_type
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

  def self.setup(args)
    x = 3
    y = 2
    p = Piece.new(x, y)
    args.state.tiles[x][y].piece = p
    p.draw(args)
  end
end
