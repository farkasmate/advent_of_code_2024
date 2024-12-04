require "./spec_helper"
require "../src/day_4"

describe "#day_4" do
  example = <<-EXAMPLE
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    EXAMPLE

  it "solves example" do
    day_4(example).should eq(18)
  end
end
