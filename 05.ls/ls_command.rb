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
    '7' => 'rwx'
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

def show_file(files_data, column_number)
  max_number = 0
  files_data.each do |i|
    max_number = i[column_number].length if max_number < i[column_number].length
  end
  max_number
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
  file_info = Array.new(files.length).map { [] }
  sum_block = files.sum { |f| File::Stat.new(f).blocks }
  files.length.times do |i|
    fs = File::Stat.new(files[i])
    file_info[i] << create_permission(fs.mode.to_s(8).rjust(6, '0'))
    file_info[i] << File::Stat.new(files[i]).nlink.to_s
    file_info[i] << Etc.getpwuid(fs.uid).name
    file_info[i] << Etc.getgrgid(fs.gid).name
    file_info[i] << File::Stat.new(files[i]).size.to_s
    file_info[i] << File::Stat.new(files[i]).mtime.month.to_s
    file_info[i] << File::Stat.new(files[i]).mtime.day.to_s
    file_info[i] << "#{File::Stat.new(files[i]).mtime.hour}:#{File::Stat.new(files[i]).mtime.min.to_s.rjust(2, '0')}"
    file_info[i] << files[i]
  end

  printf 'total %d', sum_block
  print("\n")
  file_info.each do |i|
    i.length.times do |j|
      printf(' %s', i[j].rjust(show_file(file_info, j)))
    end
    print("\n")
  end

else
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
