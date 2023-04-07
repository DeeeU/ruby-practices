# frozen_string_literal: true

class Shot
  attr_reader :score

  def initialize(score)
    @score = score
  end

  def convert_strike_score
    if @score == 'X'
      10
    else
      @score.to_i
    end
  end
end
