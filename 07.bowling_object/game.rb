# frozen_string_literal: true

class Game
  def self.show_score(scores)
    total = 0
    9.times do |i|
      total += scores[i][0] + scores[i][1]

      if scores[i][0] == 10
        total += if scores[i + 1][0] != 10
                   scores[i + 1][0] + scores[i + 1][1]
                 else
                   scores[i + 1][0] + scores[i + 2][0]
                 end
      elsif scores[i][0] + scores[i][1] == 10
        total += scores[i + 1][0]
      end
    end
    [total, scores[9..].flatten].flatten.sum
  end
end
