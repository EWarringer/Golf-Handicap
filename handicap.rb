class Handicap
  attr_accessor :set_of_rounds

  # set_of_rounds is passed to the Handicap class as an array of Round objects
  def initialize(set_of_rounds)
    @set_of_rounds = set_of_rounds
  end


  # 'calculate' calls each of the other methods to this class to formulate the
  # final handicap number, which is outputted in the variable "final"
  def calculate
    scores = self.find_score
    avg = self.average_diff(scores)
    final = avg * 0.96
    return final
  end


  # 'find_score' counts the number of rounds and determines the number of
  # scores that are to be used for the equation.
  def find_score
    num = set_of_rounds.count

    if num == 5 || num == 6
      h_scores = 1
    elsif num == 7 || num == 8
      h_scores = 2
    elsif num == 9 || num == 10
      h_scores = 3
    elsif num == 11 || num == 12
      h_scores = 4
    elsif num == 13 || num == 14
      h_scores = 5
    elsif num == 15 || num == 16
      h_scores = 6
    elsif [17, 18, 19, 20].include? num
      h_scores = num - 10
    elsif num > 20
      # If more than 20 rounds, only the 20 most recent are taken
      ascending_by_date = @set_of_rounds.sort_by &:date
      descending_by_date = ascending_by_date.reverse
      self.set_of_rounds = descending_by_date[0..19]
      h_scores = 10
    else
      # Error thrown if less than 5 rounds
      abort("A minimum of five games is required to calculate handicap.")
    end
  end


  # average_diff takes the number of scores from find_score, and averages the
  # differentials of that number of teams, starting with the lowest.
  def average_diff(scores)
    sorted_by_diff = set_of_rounds.sort_by &:differential
    new_list = sorted_by_diff[0..(scores-1)]
    diffs = []
    new_list.each { |round| diffs << round.differential }
    avg = diffs.inject(:+)/scores
    avg
  end

end
