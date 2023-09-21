class Tile
  attr_accessor :x, :y, :terrain, :piece

  def initialize(x, y, terrain)
    @x = x
    @y = y
    @terrain = terrain.downcase
  end

  def draw(args)
    px = x * TILE_SIZE
    py = y * TILE_SIZE
    tile = {
      x: px,
      y: py,
      w: TILE_SIZE,
      h: TILE_SIZE,
      a: 255
    }

    # colors from https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3
    case terrain
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
    click?(args)
    draw_border(args, tile)
  end

  # marks tile selected if user mouse clicks on it
  def click?(args)
    unless args.inputs.mouse.up #&& args.inputs.mouse.button_left
      return false
    end

    # you get multiple events for mouse clicks - this prevents more than
    # one event during a tick
    if args.state.last_mouse_up_tick_count == args.state.tick_count
      return false
    end

    # get pixel click
    mx, my = [args.inputs.mouse.x, args.inputs.mouse.y]
    # convert to grid x,y
    gx, gy = [Utils.map_pixel_x(mx), Utils.map_pixel_y(my)]

    if args.state.map_selected == [gx, gy]
      # de-select if selected
      args.state.map_selected = []
    else
      # mark selected
      args.state.map_selected = [gx, gy]
    end

    args.state.last_mouse_up_tick_count = args.state.tick_count
    return true
  end

  # draws border around tile
  # if tiles is selected it's marked with a different color
  # colors from https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3
  def draw_border(args, tile)
    border = tile.dup
    if args.state.map_selected == [x, y]
      border[:r] = 240
      border[:g] = 240
      border[:b] = 240
    else
      border[:r] = 0
      border[:g] = 0
      border[:b] = 0
    end
    args.outputs.borders << border
  end
end
