# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_reader :score

  def initialize(score)
    @score = score.split(',')
  end

  def calculate_score
    @game = create_frames
    index = 0
    total = 0
    while index < @game.size
      frame = Frame.new(@game[index][0], @game[index][1], @game[index][2])
      if last_frame?(index)
        total += frame.sum_score
      elsif frame.strike?
        total += frame.sum_score + strike_bounus(index)
      elsif frame.spare?
        total += frame.sum_score + spaire_bounus(index)
      else
        total += frame.sum_score
      end
      index += 1
    end
    puts total
  end

  private

  def create_frames
    frames = []
    frame_index = 0
    while frame_index < @score.size
      frame = Frame.new(@score[frame_index], @score[frame_index + 1])
      if frame_index == @score.size - 3
        frame = Frame.new(@score[frame_index], @score[frame_index + 1], @score[frame_index + 2])
        frames << [frame.first, frame.second, frame.third]
        frame_index += 3
      elsif frame.strike?
        frames << [frame.first]
        frame_index += 1
      else
        frames << [frame.first, frame.second]
        frame_index += 2
      end
    end
    frames
  end

  ## フレーム間での操作なのでフレーム関数に入れる必要がない
  def strike_bounus(index)
    next_frame = Frame.new(@game[index + 1][0], @game[index + 1][1], @game[index + 1][2])
    if last_frame?(index + 1)
      @game[index + 1][0] + @game[index + 1][1]
    elsif next_frame.strike?
      @game[index + 1][0] + @game[index + 2][0]
    else
      @game[index + 1][0] + @game[index + 1][1]
    end
  end

  def spaire_bounus(index)
    @game[index + 1][0]
  end

  def last_frame?(index)
    index == 9
  end

end
