# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_accessor :score

  def initialize(score)
    @score = Shot.new(score).translate_x
  end

  def arrangement_score
    frames = @score.each_slice(2).to_a
    frames[-1] << 0
    frames
  end
end
