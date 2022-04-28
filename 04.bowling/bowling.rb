# frozen_string_literal: true

scores = gets.split(',')

shots = []
scores.each do |s|
  if ["X", "X\n", "X \n"].include? s
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
  if i == 8 && frames[i][0] == 10
    total += frames[i][0] + frames[i][1]
    if frames[i + 1][0] != 10
      total += frames[i + 1][0] + frames[i + 1][1]
    else
      total += frames[i + 1][0] + frames[i + 2][0]
    end
  elsif frames[i][0] == 10
    total += frames[i][0] + frames[i][1]
    if frames[i + 1][0] == 10
      total += frames[i + 1][0] + frames[i + 2][0]
    else
      total += frames[i + 1][0] + frames[i + 1][1]
    end

  elsif frames[i][0] + frames[i][1] == 10
    total += frames[i][0] + frames[i][1] + frames[i + 1][0]

  else
    total += frames[i][0] + frames[i][1]
  end
end

total += frames[9..].flatten.inject(:+)
p total
