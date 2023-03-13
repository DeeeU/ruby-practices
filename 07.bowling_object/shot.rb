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

# aaa = Shot.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
# p aaa.translate_x
