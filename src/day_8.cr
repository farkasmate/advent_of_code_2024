require "log"

struct Coord
  property x, y

  def initialize(@x : Int32, @y : Int32)
  end

  def +(other : Coord) : Coord
    Coord.new(self.x + other.x, self.y + other.y)
  end

  def -(other : Coord) : Coord
    Coord.new(self.x - other.x, self.y - other.y)
  end
end

struct Map
  @tiles : Array(Array(Char))
  @antennas : Hash(Char, Array(Coord)) | Nil

  def initialize(input : String)
    @tiles = input.lines.map(&.chars)
  end

  def find_all(id : Char) : Array(Coord)
    @tiles.map_with_index { |row, y| row.map_with_index { |tile, x| Coord.new(x, y) if tile == id }.compact }.flatten
  end

  def includes?(coord : Coord) : Bool
    return false if coord.y < 0
    return false if coord.x < 0
    return false if coord.y > @tiles.size - 1
    return false if coord.x > @tiles[0].size - 1

    return true
  end

  def to_s
    "\n#{@tiles.map(&.join).join("\n")}"
  end

  def antennas : Hash(Char, Array(Coord))
    antennas = @antennas

    return antennas unless antennas.nil?

    antenna_ids = @tiles.map(&.join).join.chars.to_set - {'.'}
    @antennas = antenna_ids.to_h { |id| {id, self.find_all(id)} }
  end
end

def day_8(input : String) : Int32
  map = Map.new(input)

  Log.debug { map }
  Log.debug { map.antennas }

  possible_antinodes = [] of Coord

  map.antennas.each do |id, coords|
    coords.each do |coord|
      other_coords = coords - [coord]
      other_coords.each do |other_coord|
        distance = other_coord - coord
        possible_antinodes << coord - distance
        possible_antinodes << coord + distance + distance
      end
    end
  end

  valid_antinodes = possible_antinodes.select { |coord| map.includes? coord }
  unique_antinodes = valid_antinodes.to_set

  return unique_antinodes.size
end
