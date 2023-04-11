# frozen_string_literal: true

class Shot

  def initialize(score)
    @score = score
  end

  def shot
    if @score == 'X'
      10
    else
      @score.to_i
    end
  end
end
