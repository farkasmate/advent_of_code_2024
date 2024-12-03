require "log"

struct Memory
  property commands, conditional_commands

  @commands : Array(Regex::MatchData)
  @conditional_commands : Array(Regex::MatchData)

  def initialize(input : String)
    @conditional_commands = input.lines.join("#").scan(/(mul\((?<x>\d{1,3}),(?<y>\d{1,3})\)|do\(\)|don't\(\))/)
    @commands = @conditional_commands.select { |command| command[0] =~ /^mul\(/ }
  end
end

def day_3(input : String) : Int32
  memory = Memory.new(input)

  sum = memory.commands.map { |mul| mul["x"].to_i32 * mul["y"].to_i32 }.sum

  Log.debug { "sum: #{sum}" }

  return sum
end

def day_3b(input : String) : Int32
  memory = Memory.new(input)

  sum = 0
  mul_enabled = true
  memory.conditional_commands.map do |command|
    case command[0]
    when "do()"
      mul_enabled = true
    when "don't()"
      mul_enabled = false
    else
      Log.debug { "mul_enabled: #{mul_enabled}" }
      Log.debug { "command: #{command}" }
      sum += (command["x"].to_i32 * command["y"].to_i32) if mul_enabled
    end
  end

  Log.debug { "sum: #{sum}" }

  return sum
end
