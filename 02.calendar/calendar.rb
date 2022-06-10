require 'optparse'
require 'Date'

opt = ARGV.getopts('y:', 'm:')

today = Date.today
week = %w[日 月 火 水 木 金 土]

# 引数が無い際の処理
month = if opt['m'].nil?
          today.month
        else
          opt['m'].to_i
        end

year = if opt['y'].nil?
         today.year
       else
         opt['y'].to_i
       end

first_week = Date.new(year, month, 1).wday
end_month = Date.new(year, month, -1).day

puts (month.to_s + '月　' + year.to_s).center(20)
puts week.join(' ')
print '   ' * first_week

countup_until_sat = first_week

(1..end_month).each do |date|
  print date.to_s.rjust(2) + ' '
  countup_until_sat += 1
  print "\n" if countup_until_sat % 7 == 0
end

print "\n" if countup_until_sat % 7 != 0
