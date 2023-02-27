# frozen_string_literal: true

class Frame
  def self.arrangement_score(scores)
    frames = scores.each_slice(2).to_a
    frames[-1] << 0
    frames
  end
end
