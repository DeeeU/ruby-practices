require 'optparse'
require 'Date'

opt = ARGV.getopts('y:', 'm:')

today = Date.today
week = %w[日 月 火 水 木 金 土]

# 引数が無い際の処理
month = if opt['m'].nil?
          today.month
        else
          opt['m']
        end

year = if opt['y'].nil?
         today.year
       else
         opt['y']
       end

first_week = Date.new(year.to_i, month.to_i, 1).wday
end_month = Date.new(year.to_i, month.to_i, -1).day

puts (month.to_s + '月　' + year.to_s).center(20)
puts week.join(' ')
print '   ' * first_week

get_sat = first_week

(1..end_month).each do |date|
  print date.to_s.rjust(2) + ' '
  get_sat += 1
  print "\n" if get_sat % 7 == 0
end

print "\n" if get_sat % 7 != 0
