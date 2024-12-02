require "./spec_helper"
require "../src/day_1"

describe "#day_1" do
  it "solves example" do
    example = <<-EXAMPLE
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
      EXAMPLE

    day_1(example).should eq(11)
  end
end
