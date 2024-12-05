require "log"

struct Printing
  property dependent_hash, batches

  @dependent_hash : Hash(Int32, Array(Int32))
  @batches : Array(Array(Int32))

  def initialize(input : String)
    lines = input.lines
    separator_index = lines.index("") || 0
    rules = lines[0...separator_index]

    @dependent_hash = Hash(Int32, Array(Int32)).new
    rules.each do |rule|
      rule_tuple = rule.partition('|')
      @dependent_hash[rule_tuple[0].to_i32] ||= [] of Int32
      @dependent_hash[rule_tuple[0].to_i32] << rule_tuple[2].to_i32
    end

    @batches = lines[((separator_index + 1)..)].map(&.split(",").map(&.to_i32))
  end
end

def day_5(input : String) : Int32
  printing = Printing.new(input)

  valid_batches = printing.batches.select do |batch|
    valid = true
    batch.each_with_index do |page, index|
      previous_pages = batch[0...index]
      dependent_pages = printing.dependent_hash.[page]? || [] of Int32

      unless (previous_pages & dependent_pages).empty?
        valid = false
        break
      end
    end

    valid
  end

  sum = valid_batches.map do |batch|
    Log.debug { "batch #{batch} has even length" } if batch.size % 2 == 0

    middle_index = batch.size // 2
    middle_value = batch[middle_index]

    Log.debug { "middle_value: #{middle_value}" }

    middle_value
  end.sum

  return sum
end
