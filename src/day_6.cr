require "log"

struct Coord
  property x, y

  def initialize(@x : Int32, @y : Int32)
  end
end

enum Direction
  N
  E
  S
  W

  def next : Direction
    return Direction.from_value((self.value + 1) % Direction.values.size)
  end
end

struct Guard
  property coord, direction

  def initialize(@coord : Coord, @direction : Direction = Direction::N)
  end

  def turn
    @direction = @direction.next
  end
end

struct Map
  property tiles, guard

  @tiles : Array(Array(Char))

  def initialize(input : String)
    @tiles = input.lines.map(&.chars)
    @guard = Guard.new(guard_coord)
  end

  def to_s
    super.to_s.gsub('[', "\n[")
  end

  def [](coord : Coord) : Char
    return @tiles[coord.y][coord.x]
  end

  def includes?(coord : Coord) : Bool
    return false if coord.y < 0
    return false if coord.x < 0
    return false if coord.y > @tiles.size - 1
    return false if coord.x > @tiles[0].size - 1

    return true
  end

  private def guard_coord
    row = @tiles.find { |row| row.includes? '^' }
    y = @tiles.index(row) || -1
    x = row.index('^') if row
    x ||= -1

    Coord.new(x, y)
  end
end

def day_6(input : String) : Int32
  map = Map.new(input)

  Log.debug { map }

  guard = map.guard
  path = [] of Coord
  path << guard.coord

  while path.size < 9_999
    Log.debug { "guard_at: #{guard.coord}" }

    next_coord = case guard.direction
                 when Direction::N
                   Coord.new(guard.coord.x, guard.coord.y - 1)
                 when Direction::E
                   Coord.new(guard.coord.x + 1, guard.coord.y)
                 when Direction::S
                   Coord.new(guard.coord.x, guard.coord.y + 1)
                 when Direction::W
                   Coord.new(guard.coord.x - 1, guard.coord.y)
                 else
                   # NOTE: Should not happen
                   guard.coord
                 end

    break unless map.includes? next_coord

    case map[next_coord]
    when '#'
      guard.turn
      next
    when '.', '^'
      guard.coord = next_coord
    end

    path << guard.coord
  end

  Log.debug { "path_size: #{path.size}" }
  Log.debug { "path: #{path}" }

  distinct_coords = path.to_set

  return distinct_coords.size
end
