require 'file'
require 'fileutils'

class DownloadCleaner
  def initialize(user_root)
    @root = user_root
    paths = {image: File.join(@root, 'Downloads', 'Images'),
             executable: File.join(@root, 'Downloads', 'Executables')}
    #make sure your paths exists right away, rather than mid file loop
    paths.each_value do |path|
      FileUtils.mkdir_p(path) unless Dir.exist?(path)
    end
  end

  def move_file(file_path)
    begin
      dest = find_dest(file_path)
    rescue ArgumentError
      puts "File: #{file_path} was not moved"
    else
      # I'm specifically NOT rescuing on FileUtils.mv, in the event of an exception I want that to come to the terminal
      # rescuing it and saying "something went wrong" gives you absolutely no info as to what went wrong
      FileUtils.mv(file_path, dest)
      puts "File: #{file_path} moved to #{dest}"
    end
  end

  def move_files
    download_path = File.join(@root, 'Downloads')
    Dir.each_child(download_path) { |file| move_file(File.join(download_path, file)) }
  end

  def self.executable?(file)
    file.match?(/exe|dmg/)
  end

  def self.image?(str)
    str.match?(/png|jpg|svg|jpeg/)
  end

  private

  def find_dest(file_path)
    return paths[:image] if self.class.image?(file_path)
    return paths[:executable] if self.class.executable?(file_path)
    raise ArgumentError, "Path: #{file_path} is neither an image nor an executable"
  end
end

# rather than do IO with the user, just expect them to enter the username they want to clean
if ARGV.length == 1
  user_path = File.join('/Users', ARGV[0])
  cleaner = DownloadCleaner.new(user_path)
  cleaner.move_files
  puts "Done"
else
  puts "Usage - 'ruby cleanup.rb <username>'"
end

