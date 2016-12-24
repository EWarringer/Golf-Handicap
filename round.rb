# The Round class takes the csv hashes and turned them into instances of its
# class. It also calculates and provides the differential of each Round.
class Round
  attr_reader :date
  def initialize(row)
    @date = Date.strptime(row[:date], '%m/%d/%y')
    @score = row[:score].to_i
    @rating = row[:rating].to_f
    @slope = row[:slope].to_f
  end

  def differential
    ((@score - @rating) * 113) / @slope
  end
end
