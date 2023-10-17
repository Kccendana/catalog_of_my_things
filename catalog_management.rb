require_relative 'inc_helper'
class Catalog_management
  attr_accessor :items, :genres
  def initialize
    @items = []
    @genres = []
  end

  def add_music_album(music_album)
    @items << music_album
  end

  def add_genre(genre)
    @genres << genre
  end




end