require "./spec_helper"
require "../src/day_2"

describe "#day_2" do
  example = <<-EXAMPLE
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    EXAMPLE

  it "solves example" do
    day_2(example).should eq(2)
  end
end
