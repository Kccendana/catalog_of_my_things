require_relative 'inc_helper'

class MusicAlbum < Items
  attr_accessor :on_spotify, :genre

  def initialize(genre, published_date, on_spotify)
    super(published_date)
    @on_spotify = on_spotify
    @genre = genre
  end

  def can_be_archived?
    super && on_spotify
  end

  def to_json(*_args)
    {
      'id' => @id,
      'genre' => @genre.name,
      'published_date' => @published_date.to_s,
      'on_spotify' => @on_spotify
    }.to_json
  end

  def self.from_json(json_str)
    data = JSON.parse(json_str)
    genre = Genres.new(data['genre'])
    new(genre, data['published_date'], data['on_spotify'])
  end
end
