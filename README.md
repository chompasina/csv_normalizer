# CSV Normalizer

This CSV parser takes in CSVs, enforces UTF-8 character encoding, normalizes timestamps and zipcodes, uppercases names, converts durations to floating point seconds, and adds the durations together.

## To run:

_This normalizer will work best using Ruby version 2.3.0 or higher._

Clone this repo, and in the root, run `bundle install` to install necessary Gems.

## To normalize CSVs:
In the root, run `ruby normalizer.rb` + the name of your CSV file in a string. The repo comes with a sample CSV, so to run the script on this example, use `ruby normalizer.rb 'sample.csv'`. The output will be logged in `normalized.csv`.

## Testing:

Tests are written with RSpec. To run, in the root, use `rspec spec/normalizer_spec.rb`.