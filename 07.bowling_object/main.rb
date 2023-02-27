# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'
require_relative 'game'

scores = ARGV[0]
shot = Shot.translate_x(scores)
frame = Frame.arrangement_score(shot)
game = Game.show_score(frame)
puts game
