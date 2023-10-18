require_relative 'inc_helper'
Dir.chdir(__dir__)

class Genres
  attr_accessor :name
  attr_reader :id, :items

  def initialize(name)
    @id = Random.rand(1..1000)
    @name = name
    @items = []
  end

  def add_item(item)
    item.genre = self
    items << item
  end

  def to_json(*_args)
    {
      'id' => @id,
      'name' => @name,
      'items' => @items.map(&:to_json)
    }.to_json
  end

  def self.from_json(json_str)
    data = JSON.parse(json_str)
    genre = new(data['name'])
    data['items'].each do |item_data|
      music_album = Music_album.from_json(item_data)
      genre.add_item(music_album)
    end
    genre
  end
end
