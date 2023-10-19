require_relative 'inc_helper'

class Label
  attr_accessor :title, :color
  attr_reader :id, :items

  def initialize(title, color)
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

  def self.from_json(json_str)
    data = JSON.parse(json_str)
    label = new(data['title'])
    data['items'].each do |item_data|
      item = Items.from_json(item_data)
      label.add_item(item)
    end
    label
  end
end

# Assuming you have a label instance
label = Label.new('Fantasy', 'Blue')

# Create an Item (assuming Item is a subclass of Items)
item = Items.new('2023-01-15')
item.label = label

# Add the Item to the Label
label.add_item(item)
