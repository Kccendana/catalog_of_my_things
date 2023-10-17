require_relative 'inc_helper'

class Music_album < Items
  attr_accessor :on_spotify

  def initialize(genre, author, lebel, source, published_date, on_spotify)
    super(genre, author, lebel, source, published_date)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && on_spotify
  end

end