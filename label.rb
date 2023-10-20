require_relative 'inc_helper'

class Label
  attr_accessor :title, :color
  attr_reader :id, :items

  def initialize(title, color)
    @id = Random.rand(1..10_000)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    if item.label.nil?
      item.label = self
      items << item
    else
      puts "Item already has a label: #{item.label.title}"
    end
  end

  def to_hash
    {
      'id' => @id,
      'title' => @title,
      'color' => @color
    }
  end

  def self.from_json(json_str)
    data = JSON.parse(json_str)
    new(data['title'], data['color'])
  end
end
