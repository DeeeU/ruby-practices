# frozen_string_literal: true

require 'optparse'
require 'etc'

params = ARGV.getopts('lwc')
args_number = params.count { |_key, val| val.to_s.include?('true') }

def with_args(files,params,args_number)
  total_size = 0
  total_lines = 0
  total_words = 0
  files.each do |file|
    number_of_lines = 0
    number_of_words = 0
    size_of_file = File.size(file)

    File.foreach(file) do |line|
      number_of_lines += 1
      number_of_words += line.split(/\s/).count { |c| !c.empty? }
    end

    total_size += size_of_file
    total_lines += number_of_lines
    total_words += number_of_words

    puts  "#{number_of_lines} #{number_of_words} #{size_of_file}  #{file}"
  end
  puts  "#{total_lines} #{total_words} #{total_size}  total"
end

def without_args(files,params,args_number)
  number_of_lines = files.count("\n") if params['l'] || args_number.zero?
  number_of_words = files.bytesize if params['w'] || args_number.zero?
  size_of_file = files.split(/\s/).count { |c| !c.empty? } if params['c'] || args_number.zero?

  puts "#{number_of_lines} #{size_of_file} #{number_of_words}"
end

if ARGV.size.zero?
  files = $stdin.read
  without_args(files,params,args_number)
else
  files = ARGV
  with_args(files,params,args_number)
end
