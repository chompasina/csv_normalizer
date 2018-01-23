require_relative '../normalizer.rb'
require 'pry'

describe Normalizer do
  it 'can read a CSV file and writes each field as a string in an array' do
    Normalizer.new.csv_normalizer('test.csv')
    parsed_data = [["4/1/11 11:00:00 AM",
                    "123 4th St, Anywhere, AA",
                    "94121",
                    "Monkey Alberto",
                    "1:23:32.123",
                    "1:32:33.123",
                    "zzsasdfa",
                    "I am the very model of a modern major general"],
                  ["3/12/14 12:00:00 AM",
                    "Somewhere Else, In Another Time, BB",
                    "1",
                    "Superman übertan",
                    "111:23:32.123",
                    "1:32:33.123",
                    "zzsasdfa",
                    "This is some Unicode right here. ü ¡! 😀"]]
    expect(CSV.read('normalized.csv')).to eq parsed_data
  end
end
