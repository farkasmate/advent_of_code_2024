require "log"

struct Data
  property reports

  @reports : Array(Array(Int32))

  def initialize(input : String)
    @reports = input.lines.map(&.split(" ").map(&.to_i32))

    Log.debug { "reports: #{@reports}" }
  end

  def self.safe_pair(a : Int32, b : Int32, sign : Int32) : Bool
    return a != b && (b - a).sign == sign && (b - a).abs <= 3
  end

  def self.safe_report(report : Array(Int32)) : Int32
    sign = (report[1] - report[0]).sign

    bad_index = -1
    index = 0
    report.each_cons_pair do |a, b|
      unless Data.safe_pair(a, b, sign)
        bad_index = index
        break
      end
      index += 1
    end

    bad_index
  end
end

def day_2(input : String) : Int32
  data = Data.new(input)

  safe_map = data.reports.map { |report| Data.safe_report(report) == -1 }

  Log.debug { "safe_map: #{safe_map}" }

  return safe_map.count(true)
end

def day_2b(input : String) : Int32
  data = Data.new(input)

  safe_map = data.reports.map do |report|
    safe = true

    bad_index = Data.safe_report(report)
    if bad_index != -1
      without_a = report.clone
      without_a.delete_at(bad_index)
      if Data.safe_report(without_a) != -1
        without_b = report.clone
        without_b.delete_at(bad_index + 1)
        if Data.safe_report(without_b) != -1
          safe = false
        end
      end
    end

    safe
  end

  Log.debug { "safe_map: #{safe_map}" }

  return safe_map.count(true)
end
