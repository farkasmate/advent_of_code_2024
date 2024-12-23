require "./spec_helper"
require "../src/day_8"

describe "#day_8" do
  example = <<-EXAMPLE
    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    ............
    ............
    EXAMPLE

  it "solves example" do
    day_8(example).should eq(14)
  end
end
