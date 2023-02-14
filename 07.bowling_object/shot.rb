# frozen_string_literal: true

class Shot
  def initialize(score)
    @score = score.split(',')
  end

  def scores
    @shots = []
    @score.each do |s|
      if s.strip == 'X'
        @shots << 10
        @shots << 0
      else
        @shots << s.to_i
      end
    end
    @shots
  end
end
