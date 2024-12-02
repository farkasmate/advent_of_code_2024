require "log"

struct Data
  property reports

  @reports : Array(Array(Int32))

  def initialize(input : String)
    @reports = input.lines.map(&.split(" ").map(&.to_i32))

    Log.debug { "reports: #{@reports}" }
  end
end

def day_2(input : String) : Int32
  data = Data.new(input)

  safe_map = data.reports.map do |report|
    sign = (report[1] - report[0]).sign

    safe = true
    report.each_cons_pair do |a, b|
      if a == b || (b - a).sign != sign || (b - a).abs > 3
        safe = false
        break
      end
    end

    safe
  end

  Log.debug { "safe_map: #{safe_map}" }

  return safe_map.count(true)
end
