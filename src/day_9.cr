require "log"

struct DiskMap
  @data : Array(Int32)

  def initialize(input : String)
    @data = input.chomp.chars.map(&.to_i32)
  end

  def size : Int32
    @data.size
  end

  def total_file_size : Int32
    @data.each_slice(2).map(&.first).sum
  end

  def [](index : Int32) : Int32
    @data[index]
  end
end

def day_9(input : String) : Int64
  disk_map = DiskMap.new(input)

  Log.debug { disk_map }

  checksum = 0_i64
  block_index = 0
  back_index = (disk_map.size - 1) // 2 * 2
  back_id = back_index // 2
  back_id_remaining = disk_map[back_index]
  block_remaining = disk_map.total_file_size

  index = 0
  while block_remaining > 0
    id = index // 2

    if index.even?
      # process from front
      file_length = disk_map[index]

      file_length.times do |i|
        break unless block_remaining > 0

        block_remaining -= 1

        Log.debug { "file:  #{block_index} * #{id}" }
        checksum += block_index * id
        block_index += 1
      end
    else
      # process from back
      space_length = disk_map[index]

      space_length.times do |i|
        break unless block_remaining > 0

        block_remaining -= 1

        unless back_id_remaining > 0
          back_index -= 2
          back_id -= 1
          back_id_remaining = disk_map[back_index]
        end

        Log.debug { "space: #{block_index} * #{back_id}" }
        checksum += block_index * back_id
        block_index += 1
        back_id_remaining -= 1
      end
    end

    index += 1
  end

  return checksum
end
