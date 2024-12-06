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

struct Segment
  property coord, direction, next_coord

  def initialize(@coord : Coord, @direction : Direction)
    @next_coord = case @direction
                  when Direction::N
                    Coord.new(@coord.x, @coord.y - 1)
                  when Direction::E
                    Coord.new(@coord.x + 1, @coord.y)
                  when Direction::S
                    Coord.new(@coord.x, @coord.y + 1)
                  when Direction::W
                    Coord.new(@coord.x - 1, @coord.y)
                  else
                    # NOTE: Should not happen
                    @coord
                  end
  end
end

struct Guard
  property coord, direction, path

  @coord : Coord

  def initialize(@map : Map, @coord = map.guard_coord, @direction = Direction::N)
    @path = [] of Segment

    walk_path
  end

  def turn
    @direction = @direction.next
  end

  private def walk_path
    @path << Segment.new(@coord, @direction)

    while @path.size < 9_999
      Log.debug { "guard_at: #{@coord}" }

      next_coord = @path.last.next_coord

      break unless @map.includes? next_coord

      case @map[next_coord]
      when '#'
        turn
      when '.', '^'
        @coord = next_coord
      end

      next_segment = Segment.new(@coord, @direction)
      break if @path.includes? next_segment

      @path << next_segment
    end
  end
end

struct Map
  property tiles

  @tiles : Array(Array(Char))

  def initialize(input : String)
    @tiles = input.lines.map(&.chars)
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

  def guard_coord
    row = @tiles.find { |row| row.includes? '^' }
    y = @tiles.index(row) || -1
    x = row.index('^') if row
    x ||= -1

    Coord.new(x, y)
  end
end

def day_6(input : String) : Int32
  map = Map.new(input)
  guard = Guard.new(map)

  Log.debug { map }
  Log.debug { "path_size: #{guard.path.size}" }
  Log.debug { "path: #{guard.path}" }

  distinct_coords = guard.path.map(&.coord).to_set

  return distinct_coords.size
end

def day_6b(input : String) : Int32
  map = Map.new(input)
  guard = Guard.new(map)

  possible_new_obstructions = 0
  guard.path.each_with_index do |segment, index|
    if map.includes?(segment.next_coord) && map[segment.next_coord] == '.'
      turn_coord = Segment.new(segment.coord, segment.direction.next).next_coord

      turned_guard = Guard.new(map, turn_coord, segment.direction.next)
      unless (guard.path[..index] & turned_guard.path).empty?
        Log.debug { "at: #{segment.coord}" }
        Log.debug { "next: #{segment.next_coord}" }

        possible_new_obstructions += 1
      end
    end
  end

  return possible_new_obstructions
end
