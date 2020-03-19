require 'fileutils'
require 'OS'

class DownloadCleaner 
  def initialize
    @config = {
      :os => nil,
      :drive => nil,
      :username => nil,
      :path => nil
    }

    print 'Enter PC username: '
    username = gets.chomp
    @config[:username] = username

    if OS.windows?
      windows
    elsif OS.posix?
      unix
    end

    puts @config
  end

  def windows 
    @config[:os] = 'windows'

    print 'Enter Local Drive: '
    drive = gets.chomp.upcase!

    @config[:drive] = "#{drive}:/"
  end

  def unix 
    @config[:os] = 'unix'
  end
end

DownloadCleaner.new