require 'optparse'
require 'Date'

opt = ARGV.getopts("y:","m:")

today = Date.today
week = ["日","月","火","水","木","金","土"]
year = opt["y"]

if opt["m"] == nil
  month = today.month.to_s
else
  month = opt["m"]
end

first_week = Date.new(year.to_i, month.to_i, 1).wday
number_day = Date.new(year.to_i, month.to_i, -1).day

puts (month + "月　" + year).center(20)
puts week.join(" ").center(10)
print "   " * first_week

num = first_week

(1..number_day).each { |date|
  print date.to_s.rjust(2) + " "
  num += 1
  if num%7==0
    print "\n"
  end
}

if num % 7 != 0
  print "\n"
end
