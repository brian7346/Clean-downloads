require 'fileutils'
require 'OS'

puts 'Enter PC username: '
username = gets.chomp

def path username
  if OS.windows?
    return "C:/Users/#{username}/Downloads"
  end

  puts 'Ios'
  "/Users/#{username}/Downloads"
end

def image? str 
 str.match?(/png|jpg|svg|jpeg/)
end

def exe? file
 file.match?(/exe|dmg/)
end

def move_images local_path, file
  if !Dir.exist? "Images"
    begin
      FileUtils.mkdir_p 'Images'
      FileUtils.mv("#{local_path}/#{file}", "#{local_path}/Images")
    rescue
      puts 'Something went wrong!'
    end 
  else
    begin
      FileUtils.mv("#{local_path}/#{file}", "#{local_path}/Images")
    rescue
      puts 'Something went wrong!'
    end
  end
end

def move_exe local_path, file
  if !Dir.exist? "Executable"
    FileUtils.mkdir_p 'Executable'
    FileUtils.mv("#{local_path}/#{file}", "#{local_path}/Executable")
  else
    FileUtils.mv("#{local_path}/#{file}", "#{local_path}/Executable")
  end
end

if Dir.exist? path(username)
  Dir.chdir path(username)

  Dir.each_child(path(username)) { |file|
    if image? file 
      move_images path(username), file
    elsif exe? file
      move_exe path(username), file
    end
  }
  puts 'Done!'
else
  puts 'Incorrect PC username'
end