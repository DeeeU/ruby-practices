# frozen_string_literal: true

require 'optparse'
require 'etc'

params = ARGV.getopts('lwc')
args_number = params.count { |_key, val| val.to_s.include?('true') }

files = $stdin.read

number_of_lines = files.count("\n") if params['l'] || args_number.zero?
number_of_words = files.bytesize if params['w'] || args_number.zero?
size_of_file = files.split(/\s/).count { |c| !c.empty? } if params['c'] || args_number.zero?

puts "#{number_of_lines} #{size_of_file} #{number_of_words}"
