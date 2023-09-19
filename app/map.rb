module Map
  # draws the map
  # Currently just reads MAP_FILE and draws that based on
  #   w: water
  #   m: mountain
  #   .: land
  # Grid is layed out like DragonRuby so 0,0 is bottom left (so typical
  # math layout versus typical programming grid)
  def map_draw(args)
    args.state.map_txt ||= args.gtk.read_file(MAP_FILE)
    args.state.tiles ||=
      Array.new(MAX_X / TILE_SIZE) { Array.new(MAX_Y / TILE_SIZE) }

    # lines = y axis
    # colums = x axis
    args.state.map_txt.split("\n").reverse.each_with_index do |line, idy|
      # puts "#{line} :: #{idy} #{line.chars}" if idy == 0
      line.chars.each_with_index do |char, idx|
        # puts "#{char} #{idx}, #{idy}" if idy == 0
        args.state.tiles[idx][idy] = Tile.new(idx, idy, char)
        args.state.tiles[idx][idy].draw(args)
      end
    end
    Piece.new.draw(args)
  end
end
