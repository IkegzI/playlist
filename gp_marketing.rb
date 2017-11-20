current_path = File.dirname(__FILE__)
require 'find'
require 'fileutils'
require current_path + "/create_edit_playlist.rb"

puts "Form your playlist"
spisok = Search_and_create.new
spisok.search
spisok.sort_by_category_mp3
spisok.start_create

spisok.open_playlist

