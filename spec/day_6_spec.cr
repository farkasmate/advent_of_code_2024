require "./spec_helper"
require "../src/day_6"

describe "#day_6" do
  example = <<-EXAMPLE
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    EXAMPLE

  it "solves example" do
    day_6(example).should eq(41)
  end

  it "solves updated example" do
    day_6b(example).should eq(6)
  end
end
