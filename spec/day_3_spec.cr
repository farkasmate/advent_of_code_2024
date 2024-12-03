require "./spec_helper"
require "../src/day_3"

describe "#day_3" do
  example = <<-EXAMPLE
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    EXAMPLE

  it "solves example" do
    day_3(example).should eq(161)
  end
end
