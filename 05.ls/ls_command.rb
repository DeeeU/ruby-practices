# frozen_string_literal: true

def select_height(arr, width)
  (arr.length / width.to_f).ceil
end

def how_much_space(arr)
  arr.max.length
end

array = Dir.glob('*/*')
max_len = how_much_space(array)
width = 3
height = select_height(array, width)
field = array.each_slice(height).to_a

i = 0
while i < hight
  j = 0
  while j < width
    printf("%-#{max_len * 2}s", field[j][i])
    j += 1
  end
  print("\n")
  i += 1
end
