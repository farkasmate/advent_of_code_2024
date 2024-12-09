require "./spec_helper"
require "../src/day_9"

describe "#day_9" do
  example = "2333133121414131402"

  it "solves example" do
    day_9(example).should eq(1928)
  end
end
