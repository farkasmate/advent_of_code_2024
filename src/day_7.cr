require "log"

struct Equation
  property result, values

  def initialize(@result : Int64, @values : Array(Int64))
  end
end

struct Calibration
  property equations

  @equations : Array(Equation)

  def initialize(input : String)
    @equations = input.lines.map do |line|
      part = line.partition(": ")
      Equation.new(part[0].to_i64, part[2].split(' ').map(&.to_i64))
    end
  end
end

def day_7(input : String) : Int64
  calibration = Calibration.new(input)

  Log.debug { calibration }

  sum = 0_i64
  calibration.equations.each do |equation|
    possible_values = [equation.values.reduce { |acc, i|
      [acc].flatten.map do |x|
        [x + i, x * i]
      end
    }].flatten

    sum += equation.result if possible_values.includes? equation.result
  end

  return sum
end
