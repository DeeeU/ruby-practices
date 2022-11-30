# frozen_string_literal: true

def height(files_data, width)
  (files_data.length / width.to_f).ceil
end

def width(files_data, width)
  if files_data.length < width
    return files_data.length
  else
    return width
  end
end

def space(files_data)
  files_data.max_by { |a, b| a.to_f <=> b.to_f }.length
end

files = Dir.glob('*/*')
max_length = space(files)
width = width(files, 3)
height = height(files, width)
field = files.each_slice(height).to_a

height.times do |i|
  width.times do |j|
    printf("%-#{max_length * 2}s", field[j][i])
  end
  print("\n")
end
