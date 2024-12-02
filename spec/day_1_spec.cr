require "./spec_helper"
require "../src/day_1"

describe "#day_1" do
  example = <<-EXAMPLE
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    EXAMPLE

  it "solves example" do
    day_1(example).should eq(11)
  end

  it "solves updated example" do
    day_1b(example).should eq(31)
  end
end
