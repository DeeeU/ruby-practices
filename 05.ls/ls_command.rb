# frozen_string_literal: true

require 'optparse'

def height(files_data, width)
  (files_data.length / width.to_f).ceil
end

def width(files_data, width)
  if files_data.length < width
    files_data.length
  else
    width
  end
end

def field(files_data, height, width)
  (width * height - files_data.length).times do
    files_data << ' '
  end
  files_data.each_slice(height).to_a
end

def max_length(files_data)
  files_data.max_by(&:length).length
end

params = ARGV.getopts('a')
files = if params['a']
          Dir.foreach('..').to_a.sort
        else
          Dir.glob('*')
        end

max_length = max_length(files)
width = width(files, 3)
height = height(files, width)
field = field(files, height, width)

height.times do |i|
  width.times do |j|
    printf("%-#{max_length * 2}s", field[j][i])
  end
  print("\n")
end
