# frozen_string_literal: true

require './frame'
class Game < Frame
  def games
    @total = 0
    9.times do |i|
      @total += @frames[i][0] + @frames[i][1]

      if @frames[i][0] == 10
        @total += if @frames[i + 1][0] != 10
                    @frames[i + 1][0] + @frames[i + 1][1]
                  else
                    @frames[i + 1][0] + @frames[i + 2][0]
                  end

      elsif @frames[i][0] + @frames[i][1] == 10
        @total += @frames[i + 1][0]
      end
    end
    p [@total, @frames[9..].flatten].flatten.sum
  end
end

game1 = Game.new(ARGV[0])
game1.scores
game1.frames
game1.games
