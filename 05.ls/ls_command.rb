# frozen_string_literal: true

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

def max_length(files_data)
  files_data.max_by { |i| i.length }.length
end

files = Dir.glob('*')
max_length = max_length(files)
width = width(files, 3)
height = height(files, width)
field = files.each_slice(height).to_a

height.times do |i|
  width.times do |j|
    printf("%-#{max_length * 2}s", field[j][i])
  end
  print("\n")
end
