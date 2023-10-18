require_relative 'inc_helper'

class MusicAlbum < Items
  attr_accessor :on_spotify

  MusicAlbumParams = Struct.new(:genre, :author, :label, :source, :published_date, :on_spotify)

  def initialize(music_params)
    super(music_params.genre, music_params.author, music_params.label, music_params.source, music_params.published_date)
    @on_spotify = music_params.on_spotify
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
    new(MusicAlbumParams.new(genre, data['author'], data['label'], data['source'], data['published_date'],
                             data['on_spotify']))
  end
end
