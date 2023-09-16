module Map
  def map_draw_tile(args, xgrid, ygrid)
    px = xgrid * TILE_SIZE
    #py = MAX_Y - ((ygrid + 1) * TILE_SIZE)
    py = ygrid * TILE_SIZE
    tile = {
      x: px,
      y: py,
      w: TILE_SIZE,
      h: TILE_SIZE,
      a: 255
    }

    # colors from https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3
    case args.state.tiles[xgrid][ygrid][:tile].downcase
    when 'w'
      tile[:r] = 43
      tile[:g] = 140
      tile[:b] = 190
    when 'm'
      tile[:r] = 99
      tile[:g] = 99
      tile[:b] = 99
    else # default for '.'
      tile[:r] = 44
      tile[:g] = 162
      tile[:b] = 95
    end
    args.outputs.solids << tile
    map_set_tile_select(args)
    map_draw_border(args, xgrid, ygrid, tile)
  end

  # px, py: grid coords, not pixel coords
  def map_draw_border(args, px, py, tile)
    border = tile.dup
    clr = args.state.map_selected == [px, py] ? 200 : 0
    border[:r] = clr
    border[:g] = clr
    border[:b] = clr
    args.outputs.borders << border
  end

  def map_draw(args)
    args.state.map_txt ||= args.gtk.read_file(MAP_FILE)
    args.state.tiles ||=
      Array.new(MAX_X / TILE_SIZE) { Array.new(MAX_Y / TILE_SIZE, {}) }

    #x = 0
    #y = MAX_Y - TILE_SIZE
    # lines = y axis
    # colums = x axis
    args.state.map_txt.split("\n").reverse.each_with_index do |line, idy|
      puts "#{line} :: #{idy} #{line.chars}" if idy == 0
      line.chars.each_with_index do |char, idx|
        puts "#{char} #{idx}, #{idy}" if idy == 0
        args.state.tiles[idx][idy][:tile] = char
        map_draw_tile(args, idx, idy)
      end
    end
  end

  def map_set_tile_select(args)
    return unless args.inputs.mouse.button_left
    x, y = [args.inputs.mouse.x, args.inputs.mouse.y]
    mx, my = [map_pixel_x(x), map_pixel_y(y)]
    args.state.map_selected = [mx, my]
  end

  # converts x pixel to map grid x
  def map_pixel_x(x)
    return 0 if x.to_i < 1
    (x / TILE_SIZE).to_i
  end

  # converts y pixel to map grid y
  def map_pixel_y(y)
    return 0 if y.to_i < 1
    (y / TILE_SIZE).to_i
  end
end
