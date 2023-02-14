# frozen_string_literal: true

require './shot'
class Frame < Shot
  def frames
    @frames = @shots.each_slice(2).to_a
    @frames[-1] << 0
    @frames
  end
end
