require_relative 'inc_helper'

class Authors
  attr_accessor :fname, :lname
  attr_reader :id, :items

  def initialize(fname, lname)
    @id = Random.rand(1..10_000)
    @fname = fname
    @lname = lname
    @items = []
  end

  def add_item(item)
    item.author = self
    items << item
  end

  def to_json(*_args)
    {
      'id' => @id,
      'fname' => @fname,
      'lname' => @lname,
      'items' => @items.map(&:to_json)
    }.to_json
  end

  def self.from_json(json_str)
    data = JSON.parse(json_str)
    author = new(data['fname'], data['lname'])
    data['items'].each do |item_data|
      games = Games.from_json(item_data)
      author.add_item(games)
    end
    author
  end
end
