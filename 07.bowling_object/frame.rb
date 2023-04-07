# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_accessor :first, :second, :third

  def initialize(first, second = nil, third = nil)
    @first = Shot.new(first).convert_strike_score.to_i
    @second = Shot.new(second).convert_strike_score.to_i
    @third = Shot.new(third).convert_strike_score.to_i
  end

  def strike?
    @third.zero? && @first == 10
  end

  def spare?
    @third.zero? && @first < 10 && @first + @second == 10
  end

  def sum_score
    @first + @second + @third
  end
end
