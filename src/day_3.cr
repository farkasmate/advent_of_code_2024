require "log"

struct Memory
  property commands

  @commands : Array(Regex::MatchData)

  def initialize(input : String)
    @commands = input.lines.join("#").scan(/mul\((?<x>\d{1,3}),(?<y>\d{1,3})\)/)
  end
end

def day_3(input : String) : Int32
  memory = Memory.new(input)

  sum = memory.commands.map { |mul| mul["x"].to_i32 * mul["y"].to_i32 }.sum

  Log.debug { sum }

  return sum
end
