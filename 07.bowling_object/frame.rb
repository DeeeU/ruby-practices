# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first, :second, :third

  def initialize(first, second = nil, third = nil)
    @first = Shot.new(first)
    @second = Shot.new(second)
    @third = Shot.new(third)
  end

  def strike?
    @first.score == 10
  end

  def spare?
    @first.score < 10 && @first.score + @second.score == 10
  end

  def sum_score
    @first.score + @second.score + @third.score
  end
end
