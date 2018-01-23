require 'csv'
require 'pry'
class Normalizer
  def csv_normalizer(file)
    CSV.open 'normalized.csv', 'wb', col_sep: "," do |csv|
      normalized_data = CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
        csv << row
      end
    end
  end
end

