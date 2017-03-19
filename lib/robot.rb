class Robot

# Constant: valid robot directions
  DIRECTIONS = ["NORTH", "EAST", "SOUTH", "WEST"]

  attr_accessor :x, :y, :direction, :placed

# Initialize a robot
  def initialize(tabletop, commands)
    @tabletop = tabletop
    @placed = false
    @commands = commands

    run_commands
  end

# Send commands to the robot
  def run_commands
    raise "First command must be: PLACE" unless (/PLACE/).match @commands.first


    @commands.each do |cmd|
      @action = cmd.split(" ").first
      case @action
      when "PLACE"
        place = cmd.split(/\s|\,/)
        @x = Integer(place[1])
        @y = Integer(place[2])
        raise "Placement is out of bounds" unless @tabletop.table_boundary?(@x, @y)
        @direction = place[3].to_s
        raise "Not a valid direction. Must be either: NORTH, EAST, SOUTH, WEST." unless DIRECTIONS.include?(@direction)
        @placed = true
      when "MOVE"
        move
      when "LEFT"
        rotate_left
      when "RIGHT"
        rotate_right
      when "REPORT"
        report
      end
    end
  end

# Rotate left by 90 degrees
  def rotate_left
    placed?
    @direction = case @direction
      when "NORTH" then "WEST"
      when "EAST" then "NORTH"
      when "SOUTH" then "EAST"
      when "WEST" then "SOUTH"
    end
  end

# Rotate right by 90 degrees
  def rotate_right
    placed?
    @direction = case @direction
      when "NORTH" then "EAST"
      when "EAST" then "SOUTH"
      when "SOUTH" then "WEST"
      when "WEST" then "NORTH"
    end
  end

# Move one unit forward
  def move
    placed?
    if @direction == "NORTH"
      raise "Out of bounds" unless @tabletop.table_boundary?(@x, (@y+1))
      @y+=1
    elsif @direction == "SOUTH"
      raise "Out of bounds" unless @tabletop.table_boundary?(@x, (@y-1))
      @y-=1
    elsif @direction == "WEST"
      raise "Out of bounds" unless @tabletop.table_boundary?((@x-1), @y)
      @x-=1
    elsif @direction == "EAST"
      raise "Out of bounds" unless @tabletop.table_boundary?((@x+1), @y)
      @x+=1
    end
  end

  def placed?
    raise "Robot is not on the tabletop, run the PLACE command first" unless @placed == true
    true
  end

# Report robot position
  def report
    # print "#{@x}, #{@y}, #{@direction}"
    [@x, @y, @direction]
  end

end
