require 'find'
require 'date'
class Search_and_create
  attr_reader :list_mp3_pesni, :list_mp3_rolic

  def initialize
    @list_mp3_pesni= []
    @list_mp3_rolic = []
    @list_mp3 = []
    @curent_path = File.dirname(__FILE__)
  end

  def search
    Find.find(@curent_path) do |path|
      if File.directory?(path)
        if File.basename(path)[0] == ?.
          Find.prune
        else
          next
        end
      elsif File.fnmatch("*.mp3", path)
        @list_mp3 << path
      end
    end
  end

  def sort_by_category_mp3
    @list_mp3.each do |value|
      val=""
      why_musik = value.split("/") - @curent_path.split("/")
      if why_musik.include?("rolic")
        why_musik.each do |value|
          if why_musik[-1] == value
            val=val+value
          else
            val=val+value+"\\"
          end
        end
        @list_mp3_rolic << val
      else
        why_musik.each do |value|
          if why_musik[-1] == value
            val=val+value
          else
            val=val+value+"\\"
          end
        end
        @list_mp3_pesni << val
      end
    end
  end

  def start_create
    playlist = File.new("#{Date.today}.aimppl", "w")
    playlist.write "#ID:{E4DD32E3-CFF1-4E00-903B-5C77EDA95496}\n"
    playlist.write "#Name:#{Date.today}_playlist\n"

    index = 0
    rand_value = ["111"]
    value = "111"
    while index <= @list_mp3_pesni.size
      @list_mp3_pesni = @list_mp3_pesni - rand_value

      loop do
      value = @list_mp3_pesni[rand(@list_mp3_pesni.size)]
      if rand_value.include?(value) == false
        break
      end
      end
      rand_value << value
      playlist.write "#Track:1|"+"#{value}"+"|||||||||||||\n"

      index +=1
      if index.remainder(3) == 0 && index >= 3
        @list_mp3_rolic.each do |value|
          playlist.write "#Track:1|"+"#{value}"+"|||||||||||||\n"
        end
      end
    end
    playlist.close
  end

  def open_playlist
    #system('@curent_path')
    open_list = Date.today.to_s + ".aimppl"
    puts open_list
    system("start #{open_list}")
  end

end
