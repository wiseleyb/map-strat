require_relative 'map'

MAP_FILE = 'map-64.txt'
MAX_X = 1280
MAX_Y = 720
TILE_SIZE = 64

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
  map_draw(args) # reads map-{?}.txt and draws map
end

$gtk.reset
