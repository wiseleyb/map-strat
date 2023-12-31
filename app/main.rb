require_relative 'map'
require_relative 'piece'
require_relative 'tile'
require_relative 'utils'

MAP_FILE = 'data/map-64.txt'
PIECE_PADDING_X = 22
PIECE_PADDING_Y = 12
MAX_X = 1280
MAX_Y = 720
TILE_SIZE = 64

MAX_GRID_X = (MAX_X / TILE_SIZE).to_i
MAX_GRID_Y = (MAX_Y / TILE_SIZE).to_i

# state
#   map_txt: text file map is drawn from
#   map: [MAX_X/TILE_SIZE, MAZ_Y/TILE_SIZE] of hashes
#     map hash keys
#     tile = [., m, w]
#       . = land
#       m = mountain
#       w = water
#   map_selected = [x, y]
include Map

def tick(args)
  #args.gtk.slowmo! 120
  map_draw(args) # reads map-{?}.txt and draws map
  Piece.setup(args)
end

$gtk.reset
