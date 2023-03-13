# frozen_string_literal: true

class Shot
  attr_accessor :score

  def initialize(score)
    @score = score
  end

  def translate_x
    shots = []
    @score.split(',').each do |i|
      if i.strip == 'X'
        shots << 10
        shots << 0
      else
        shots << i.to_i
      end
    end
    shots
  end
end
