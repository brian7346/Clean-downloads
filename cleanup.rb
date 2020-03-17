require 'fileutils'

puts 'Enter PC username: '
username = gets.chomp
path = "/Users/#{username}/Downloads"

def is_image? str 
  if str.match?(/png|jpg|svg|jpeg/)
    return true
  end

  false
end

def is_exe? file
  if file.match(/exe|dmg/)
    return true
  else

  false
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