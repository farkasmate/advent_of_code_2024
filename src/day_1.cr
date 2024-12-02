require "log"

def day_1(input : String) : Int32
  left_column = [] of Int32
  right_column = [] of Int32

  input.each_line do |line|
    match = /^(?<left>\d+)\ +(?<right>\d+)$/.match(line)

    left = match.try &.["left"].to_i32
    right = match.try &.["right"].to_i32

    left_column << left if left
    right_column << right if right
  end

  left_column.sort!
  right_column.sort!

  diffs = [] of Int32
  left_column.size.times do |i|
    diffs << (left_column[i] - right_column[i]).abs
  end

  Log.debug { "left_column: #{left_column}" }
  Log.debug { "right_column: #{right_column}" }
  Log.debug { "diffs: #{diffs}" }

  return diffs.sum
end
