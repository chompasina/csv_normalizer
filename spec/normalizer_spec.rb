require_relative '../normalizer.rb'

describe Normalizer do
  it 'can read a CSV file and writes each field as a string in an array' do
    Normalizer.csv_normalizer('test.csv')
    parsed_data = [["2011-04-01T13:00:00-04:00",
                    "123 4th St, Anywhere, AA",
                    "94121",
                    "MONKEY ALBERTO",
                    "5012.123",
                    "5553.123",
                    "10565.246",
                    "I am the very model of a modern major general"],
                  ["2014-03-12T14:00:00-04:00",
                    "Somewhere Else, In Another Time, BB",
                    "00001",
                    "SUPERMAN ÜBERTAN",
                    "401012.123",
                    "5553.123",
                    "406565.24600000004",
                    "This is some Unicode right here. ü ¡! 😀"]]
    expect(CSV.read('normalized.csv')).to eq (parsed_data)
  end

  it 'can read UTF-8 character set' do
    Normalizer.csv_normalizer('test.csv')
    expect(CSV.read('normalized.csv').all? { |row| row.each { |field| field.encoding.to_s == "UTF-8" }}).to eq (true)
  end

  it 'converts reads time as Pacific and converts to Eastern with ISO formatting' do
    expect(Normalizer.convert_zone("4/1/11 11:00:00 AM PST")).to eq ("2011-04-01T13:00:00-04:00") # April 1 is during Eastern Daylight Time
  end

  it 'standardizes zipcode to have 5 digits' do
    expect(Normalizer.standardize_zipcode('1')).to eq ("00001")
    expect(Normalizer.standardize_zipcode('')).to eq ("00000")
  end

  it 'upcases names' do
    expect(Normalizer.upcase_name("Monkey Alberto")).to eq ("MONKEY ALBERTO")
    expect(Normalizer.upcase_name("Superman übertan")).to eq ("SUPERMAN ÜBERTAN")
  end

  it 'converts seconds' do
    expect(Normalizer.convert_seconds("1:23:32.123")).to eq (5012.123)
    expect(Normalizer.convert_seconds("111:23:32.123")).to eq (401012.123)
  end

  it 'adds durations' do
    expect(Normalizer.add_durations(5012.123,5553.123)).to eq(10565.246)
  end
end
