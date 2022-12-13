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

def field(files_data, height, width)
  (width * height - files_data.length).times do
    files_data << ' '
  end
  files_data.each_slice(height).to_a
end

def max_length(files_data)
  max_length = 0
  files_data.each do |i|
    max_length = i.length if max_length < i.length
  end
  max_length
end

if ARGV[0] == '-a'
  files = []
  Dir.foreach('.'){|f|
    files <<  f
  }
else
  files = Dir.glob('*')
end

width = width(files, 3)
height = height(files, width)
field = field(files, height, width)

height.times do |i|
  width.times do |j|
    printf("%-#{max_length(files) * 2}s", field[j][i])
  end
  print("\n")
end
