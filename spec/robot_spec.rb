require 'byebug'
require 'spec_helper'
require_relative '../lib/robot.rb'
require_relative '../lib/tabletop.rb'

RSpec.describe Robot do
  before(:all) do
    @tabletop = Tabletop.new(5,5)
  end

  context "place robot" do
    it "reports on the robot" do
      robot = Robot.new(@tabletop, ['PLACE 0,0,NORTH'])
      expect( robot.report ).to eq([0, 0, 'NORTH'])
    end

    it "places the robot" do
      robot = Robot.new(@tabletop, ['PLACE 0,0,NORTH'])
      expect( robot.placed?).to eq(true)
    end
  end

  context "rotates the robot" do
    it "rotates left" do
      robot = Robot.new(@tabletop, ['PLACE 0,0,NORTH', 'LEFT'])
      expect( robot.report ).to eq([0, 0, 'WEST'])
    end

    it "rotates right" do
      robot = Robot.new(@tabletop, ['PLACE 0,0,NORTH', 'RIGHT'])
      expect( robot.report ).to eq([0, 0, 'EAST'])
    end
  end

  context "moves the robot" do
    it "moves 3 spaces north, turns right then moves 2 spaces" do
      robot = Robot.new(@tabletop, ['PLACE 0,0,NORTH','MOVE','MOVE','MOVE','RIGHT','MOVE','MOVE'])
      expect( robot.report ).to eq([2, 3, 'EAST'])
    end

    it "faces south, moves 5 times, turns to north, moves 2 times" do
      robot = Robot.new(@tabletop, ['PLACE 0,0,SOUTH','LEFT','LEFT','MOVE','MOVE'])
      expect( robot.report ).to eq([0, 2, 'NORTH'])
    end
  end

end
