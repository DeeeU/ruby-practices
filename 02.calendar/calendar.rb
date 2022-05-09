require 'optparse'
require 'Date'

opt = ARGV.getopts('y:', 'm:')

today = Date.today
week = %w[日 月 火 水 木 金 土]
year = opt['y']

# 引数が無い際の処理
month = if opt['m'].nil?
          today.month.to_s
        else
          opt['m']
        end

year = if opt['y'].nil?
         today.year.to_s
       else
         opt['y']
       end

first_week = Date.new(year.to_i, month.to_i, 1).wday
number_day = Date.new(year.to_i, month.to_i, -1).day

puts (month + '月　' + year).center(20)
puts week.join(' ').center(10)
print '   ' * first_week

num = first_week

(1..number_day).each do |date|
  print date.to_s.rjust(2) + ' '
  num += 1
  print "\n" if num % 7 == 0
end

print "\n" if num % 7 != 0
