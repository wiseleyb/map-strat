class Utils
  class << self
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

    # convert grid x to pixel
    def map_grid_x(x)
      (x * TILE_SIZE).to_i
    end

    # convert grid y to pixel
    def map_grid_y(y)
      # invert since y:0 is bottom left
      ((MAX_GRID_Y - y) * TILE_SIZE).to_i
    end
  end
end
