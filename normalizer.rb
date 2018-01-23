require 'csv'
require 'time'
require 'active_support/time'
require 'pry'

class Normalizer
  def csv_normalizer(file)
    CSV.open 'normalized.csv', 'wb', col_sep: "," do |csv|
      normalized_data = CSV.foreach(file, headers: true, header_converters: :symbol, encoding: "utf-8:utf-8") do |row|
        row[:timestamp] = convert_zone(row[:timestamp])
        row[:zip] = standardize_zipcode(row[:zip])
        row[:fullname] = upcase_name(row[:fullname])
        row[:fooduration] = convert_seconds(row[:fooduration])
        row[:barduration] = convert_seconds(row[:barduration])
        row[:totalduration] = add_durations(row[:fooduration], row[:barduration])
        csv << row
      end
    end
  end

  def convert_zone(time)
    Time.use_zone("America/New_York") do
      formatted_time = Time.strptime(time + " PST", '%m/%d/%y %H:%M:%S %z').to_s
      Time.zone.parse(formatted_time).iso8601
    end
  end

  def standardize_zipcode(zip)
    zip.to_s.rjust(5,"0")[0..4]
  end

  def upcase_name(name)
    name.mb_chars.upcase.to_s
  end

  def convert_seconds(time)
    hours = time.split(":").first.to_f
    minutes = time.split(":")[1].to_f
    seconds = time.split(":").last.to_f

    d, h = hours.divmod(24)
    hh, m = minutes.divmod(60)
    mm, ss = seconds.divmod(60)
    total = ((d * 24 * 60 * 60) + ((h + hh) * 60 * 60) + ((m + mm) * 60) + ss)
  end

  def add_durations(foo, bar)
    foo + bar
  end
end

