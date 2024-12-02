require "log"

struct List
  property left_column, right_column, size

  def initialize(input : String)
    @left_column = [] of Int32
    @right_column = [] of Int32

    input.each_line do |line|
      match = /^(?<left>\d+)\ +(?<right>\d+)$/.match(line)

      left = match.try &.["left"].to_i32
      right = match.try &.["right"].to_i32

      @left_column << left if left
      @right_column << right if right
    end

    @size = @left_column.size

    Log.debug { "left_column: #{@left_column}" }
    Log.debug { "right_column: #{@right_column}" }
  end
end

def day_1(input : String) : Int32
  list = List.new(input)

  list.left_column.sort!
  list.right_column.sort!

  diffs = [] of Int32
  list.size.times do |i|
    diffs << (list.left_column[i] - list.right_column[i]).abs
  end

  Log.debug { "diffs: #{diffs}" }

  return diffs.sum
end

def day_1b(input : String) : Int32
  list = List.new(input)

  list.left_column.sort!
  list.right_column.sort!

  similarity_score = 0
  list.left_column.each do |id|
    similarity_score += id * list.right_column.count(id)
  end

  return similarity_score
end
