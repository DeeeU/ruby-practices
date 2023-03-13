# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_accessor :score

  def initialize(score)
    @score = Frame.new(score).arrangement_score
  end

  def show_score
    total = 0
    9.times do |i|
      total += @score[i][0] + @score[i][1]

      if @score[i][0] == 10
        total += if @score[i + 1][0] != 10
                   @score[i + 1][0] + @score[i + 1][1]
                 else
                   @score[i + 1][0] + @score[i + 2][0]
                 end
      elsif @score[i][0] + @score[i][1] == 10
        total += @score[i + 1][0]
      end
    end
    [total, @score[9..].flatten].flatten.sum
  end
end
