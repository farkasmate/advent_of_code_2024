require "./spec_helper"
require "../src/day_3"

describe "#day_3" do
  it "solves example" do
    example = <<-EXAMPLE
      xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
      EXAMPLE

    day_3(example).should eq(161)
  end

  it "solves updated example" do
    example = <<-EXAMPLE
      xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
      EXAMPLE

    day_3b(example).should eq(48)
  end
end
