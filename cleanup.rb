require 'fileutils'

puts 'Enter PC username: '
username = gets.chomp
path = "/Users/#{username}/Downloads"

def is_image? str 
 str.match?(/png|jpg|svg|jpeg/)
end

def is_exe? file
 file.match?(/exe|dmg/)
end

def move_images path, file
  if !Dir.exist? "Images"
    begin
      FileUtils.mkdir_p 'Images'
      FileUtils.mv("#{path}/#{file}", "#{path}/Images")
    rescue
      puts 'Something went wrong!'
    end 
  else
    begin
      FileUtils.mv("#{path}/#{file}", "#{path}/Images")
    rescue
      puts 'Something went wrong!'
    end
  end
end

def move_exe path, file
  if !Dir.exist? "Executable"
    FileUtils.mkdir_p 'Executable'
    FileUtils.mv("#{path}/#{file}", "#{path}/Executable")
  else
    FileUtils.mv("#{path}/#{file}", "#{path}/Executable")
  end
end

if Dir.exist? path
  Dir.chdir path
  Dir.each_child(path) { |file|
    if is_image? file 
      move_images path, file
    elsif is_exe? file
      move_exe path, file
    end
  }
  puts 'Done!'
else
  puts 'Incorrect PC username'
end