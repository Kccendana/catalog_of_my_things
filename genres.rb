require_relative 'inc_helper'

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
end