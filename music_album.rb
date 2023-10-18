require_relative 'inc_helper'

class MusicAlbum < Items
  attr_accessor :on_spotify

  def initialize(genre, author, label, source, published_date, on_spotify)
    super(genre, author, label, source, published_date)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && on_spotify
  end

  def to_json(*_args)
    {
      'id' => @id,
      'genre' => @genre.name,
      'author' => @author,
      'label' => @label,
      'source' => @source,
      'published_date' => @published_date.to_s,
      'on_spotify' => @on_spotify
    }.to_json
  end

  def self.from_json(json_str)
    data = JSON.parse(json_str)
    genre = Genres.new(data['genre'])
    new(genre, data['author'], data['label'], data['source'], data['published_date'], data['on_spotify'])
  end
end
