class Tabletop

  def initialize(max_x, max_y)
    @x = max_x
    @y = max_y
  end

# Table constraints
  def table_boundary?(x, y)
    return false if x < 0
    return false if y < 0
    return false if x > @x
    return false if y > @y

    true
  end

end
