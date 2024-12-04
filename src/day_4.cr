require "log"

struct WordSearch
  @data : Array(Array(Char))

  def initialize(input : String)
    @data = input.lines.map(&.chars)
  end

  def each_column
    @data.transpose.each { |column| yield column.join }
  end

  def each_row
    @data.each { |row| yield row.join }
  end

  def each_se_diagonal
    @data.map_with_index do |row, index|
      (['-'] * (row.size - 1) + row).rotate(index)
    end.transpose.each do |diagonal|
      yield diagonal.join.strip('-')
    end
  end

  def each_sw_diagonal
    @data.map_with_index do |row, index|
      (row + ['-'] * (row.size - 1)).rotate(row.size * 2 - index - 1)
    end.transpose.each do |diagonal|
      yield diagonal.join.strip('-')
    end
  end
end

def day_4(input : String) : Int32
  word_search = WordSearch.new(input)

  count = 0
  xmas_proc = ->(line : String) do
    Log.debug { line }
    count += line.split("XMAS").size + line.split("SAMX").size - 2
  end

  word_search.each_row { |line| xmas_proc.call line }
  word_search.each_column { |line| xmas_proc.call line }
  word_search.each_se_diagonal { |line| xmas_proc.call line }
  word_search.each_sw_diagonal { |line| xmas_proc.call line }

  return count
end
