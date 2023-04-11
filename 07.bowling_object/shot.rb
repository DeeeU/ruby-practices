# frozen_string_literal: true

class Shot

  def initialize(original_score)
    @original_score = original_score
  end

  def score
    if @original_score == 'X'
      10
    else
      @original_score.to_i
    end
  end
end
