# frozen_string_literal: true

require 'optparse'
require 'etc'

def create_permission(oct_code)
  permission = ''
  permission += file_type(oct_code[0..1])
  3.times do |i|
    permission += authority(oct_code[i + 3])
  end
  permission
end

def file_type(code)
  file_type = {
    '01' => 'p',
    '02' => 'c',
    '04' => 'd',
    '06' => 'b',
    '10' => '-',
    '12' => 'l',
    '14' => 's'
  }
  file_type[code]
end

def authority(code)
  authority = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx',
  }
  authority[code]
end

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

params = ARGV.getopts('a', 'r', 'l')
files = if params['a']
          Dir.foreach('.').to_a.sort
        elsif params['r']
          Dir.glob('*').reverse
        else
          Dir.glob('*')
        end

max_length = max_length(files)
if params['l']
  file_info = []
  sum_block = 0

  files.each do |i|
    fs = File::Stat.new(i)
    sum_block += fs.blocks
    file_info << create_permission(fs.mode.to_s(8).rjust(6, '0'))
    file_info << File::Stat.new(i).nlink
    file_info << Etc.getpwuid(fs.uid).name
    file_info << Etc.getgrgid(fs.gid).name
    file_info << File::Stat.new(i).size
    file_info << File::Stat.new(i).mtime.month
    file_info << File::Stat.new(i).mtime.day
    file_info << "#{File::Stat.new(i).mtime.hour}:#{File::Stat.new(i).mtime.min}"
    file_info << i
  end

  printf 'total %d', sum_block
  print("\n")

  file_info.each_with_index do |item, num|
    printf("%-#{max_length}s ", item)
    print("\n") if ((num + 1) % 9).zero?
  end

else
  max_length = max_length(files)
  width = width(files, 3)
  height = height(files, width)
  sorted_files = field(files, height, width)

  height.times do |i|
    width.times do |j|
      printf("%-#{max_length}s ", sorted_files[j][i])
    end
    print("\n")
  end
end
