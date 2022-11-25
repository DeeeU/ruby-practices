# frozen_string_literal: true

def set_height(files_data, width)
  (files_data.length / width.to_f).ceil
end

def space(files_data)
  files_data.max {|a, b| a.to_f <=> b.to_f}.length
end


begin
  files = Dir.glob('*')
  max_length = space(files)
  width = 3
  height = set_height(files, width)
  field = files.each_slice(height).to_a

  i = 0
  height.times do |i|
    width.times do |j|
      printf("%-#{max_length * 2}s", field[j][i])
    end
    print("\n")
  end
rescue => e
  exit
end
