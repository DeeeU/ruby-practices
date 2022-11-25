# frozen_string_literal: true

def select_height(arr, width)
  (arr.length / width.to_f).ceil
end

def how_much_space(arr)
  arr.max {|a, b| a.to_f <=> b.to_f}.length
end


begin
  files = Dir.glob('*')
  max_length = how_much_space(files)
  width = 3
  height = select_height(files, width)
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
