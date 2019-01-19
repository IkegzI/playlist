require 'find'
require 'date'
#require 'pry'
class Search_and_create

  def initialize
    @list_mp3_pesni= []
    @list_mp3_rolic = []
    @list_mp3 = []
    @curent_path = File.dirname(__FILE__)
  end
  # search all tracks
  def search
    Find.find(@curent_path) do |path|
      if File.directory?(path)
        if File.basename(path)[0] == ?.
          Find.prune
        else
          next
        end
      elsif File.fnmatch("*.mp3", path) || File.fnmatch("*.wav", path) || File.fnmatch("*.flac", path) || File.fnmatch("*.wma", path)
        @list_mp3 << path
      end
    end
  end

  def sort_by_category_mp3
    @list_mp3.each do |value|

      why_musik = value.split("/") - @curent_path.split("/")
      if why_musik.include?("rolic")
        why_musik.join("\\")
        @list_mp3_rolic << why_musik.join("\\")
      else
        @list_mp3_pesni << why_musik.join("\\")
      end

    end
  end

  #create a playlist and write it to a file
  def start_create
    # create file
    playlist = File.new("#{Date.today}.aimppl", "w")
    playlist.write "#ID:{E4DD32E3-CFF1-4E00-903B-5C77EDA95496}\n"
    playlist.write "#Name:#{Date.today}_playlist\n"
    index = 0
    # advertising every 3 tracks
    while @list_mp3_pesni.size > 0

      track = @list_mp3_pesni.delete(@list_mp3_pesni[rand(@list_mp3_pesni.size)])
      playlist.write "#Track:1|"+"#{track}"+"|||||||||||||\n"

      index += 1
      # advertising every 3 tracks
      if (index % 3) == 0
        @list_mp3_rolic.each_with_index do |item|
          playlist.write "#Track:1|"+"#{item}"+"|||||||||||||\n"
        end
      end

    end

    playlist.close

  end

  def open_playlist
    # if there is a program for opening a playlist file - open
    open_list = Date.today.to_s + ".aimppl"
    puts open_list
    system("start #{open_list}")

  end

end
