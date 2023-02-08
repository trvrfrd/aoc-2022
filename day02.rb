input = File.read(File.expand_path("input_day02.txt", File.dirname(__FILE__)))

class RPS
  OUTCOME_VALUES = {
    :win => 6,
    :draw => 3,
    :lose => 0,
  }.freeze

  class Hand
    def self.score_versus(other)
      if self.beats == other
        OUTCOME_VALUES[:win] + self.value
      elsif self == other
        OUTCOME_VALUES[:draw] + self.value
      else
        OUTCOME_VALUES[:lose] + self.value
      end
    end
  end

  class Rock < Hand
    def self.beats
      Scissors
    end

    def self.value
      1
    end
  end

  class Paper < Hand
    def self.beats
      Rock
    end

    def self.value
      2
    end
  end

  class Scissors < Hand
    def self.beats
      Paper
    end

    def self.value
      3
    end
  end

  def self.score_round_from_cheat_sheet(opponent_hand_str, own_hand_str)
    opponent_hand = HAND_ALIASES[opponent_hand_str]
    own_hand = HAND_ALIASES[own_hand_str]

    own_hand.score_versus(opponent_hand)
  end

  HAND_ALIASES = {
    "A" => Rock,
    "X" => Rock,

    "B" => Paper,
    "Y" => Paper,

    "C" => Scissors,
    "Z" => Scissors,
  }.freeze
end

# # TEST!
# puts score_round("A", "Y") # 8
# puts score_round("B", "X") # 1
# puts score_round("C", "Z") # 6

# Part 1
total_score = input.split(/\n/).map do |s|
  RPS.score_round_from_cheat_sheet(s[0], s[-1])
end.sum

# expected: 10718
puts total_score

# Part 2
class RPS
  OUTCOME_ALIASES = {
    "X" => :lose,
    "Y" => :draw,
    "Z" => :win,
  }.freeze

  class Hand
    def self.beaten_by
      # just trust me
      self.beats.beats
    end
  end

  def self.corrected_score_round_from_cheat_sheet(opponent_hand_str, outcome_str)
    opponent_hand = HAND_ALIASES[opponent_hand_str]
    outcome = OUTCOME_ALIASES[outcome_str]

    own_hand = 
    if outcome == :win
      opponent_hand.beaten_by
    elsif outcome == :lose
      opponent_hand.beats
    else # draw
      opponent_hand
    end

    own_hand.score_versus(opponent_hand)
  end
end

# Part 2
total_score = input.split(/\n/).map do |s|
  RPS.corrected_score_round_from_cheat_sheet(s[0], s[-1])
end.sum

# expected: 14652
puts total_score