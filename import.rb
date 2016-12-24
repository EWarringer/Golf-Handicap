require 'csv'

# using separate files for the classes
require_relative 'round'
require_relative 'handicap'



set_of_rounds = []
# The loop below takes each row of the CSV file, makes it an instance of
# a round, and puts it into the array above.
CSV.foreach('rounds.csv', headers: true, header_converters: :symbol) do |row|
  # Round class in round.rb
  set_of_rounds << Round.new(row)
end

# handicap class in handicap.rb - Handicap class takes the array of Round
# objects and finds the handicap for the golfer.
handicap = Handicap.new(set_of_rounds)
# 'handicap.calculate' returns a Handicap number based on formulas in the class.
magic_number = handicap.calculate
print "Your golf handicap is #{'%.2f' % magic_number}"
