score = gets.split(',')
round_number = 0
round_score = 0
total = 0

score.size.times {|i|
  if score[i] == "X"
    total += 10
    round_number = 2
    round_score = "X"
  else
    # p score[i].to_i
    total += score[i].to_i
    round_number += 1
    # round_score += score[i].to_i
  end
}
puts total
