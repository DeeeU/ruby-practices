# frozen_string_literal: true

scores = gets.split(',')

shots = []
scores.each do |s|
  if s.strip == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a
frames[-1] << 0

total = 0

9.times do |i|
  total += frames[i][0] + frames[i][1]

  if frames[i][0] == 10
    total += if frames[i + 1][0] != 10
               frames[i + 1][0] + frames[i + 1][1]
             else
               frames[i + 1][0] + frames[i + 2][0]
             end

  elsif frames[i][0] + frames[i][1] == 10
    total += frames[i + 1][0]
  end
end

p [total, frames[9..].flatten].flatten.sum
