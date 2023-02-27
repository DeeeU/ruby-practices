# frozen_string_literal: true

class Shot
  def self.translate_x(scores)
    shots = []
    scores.split(',').each do |i|
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
