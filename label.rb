class Label
  attr_accessor :title, :color
  attr_reader :id, :items

  def initialize(title, color)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    item.label = self
    items << item
  end

  def self.from_json(json_str)
    data = JSON.parse(json_str)
    label = new(data['title'])
    data['items'].each do |item_data|
      book = Book.from_json(item_data)
      label.add_item(book)
    end
    label
  end
end
