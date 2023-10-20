require_relative 'inc_helper'

class Book < Items
  attr_accessor :cover_state, :label
  attr_reader :id, :archived

  def initialize(label, published_date, cover_state, _archived: false)
    super(published_date)
    @cover_state = cover_state
    @archived = can_be_archived?
    @label = label
  end

  def to_hash
    { 'id' => @id,
      'label' => @label,
      'published_date' => @published_date.to_s,
      'cover_state' => @cover_state,
      'can_be_archived' => @archived }
  end

  def self.from_json(json_str)
    data = JSON.parse(json_str)
    new(data['label'], data['published_date'], data['cover_state'])
  end

  def can_be_archived?
    state = @cover_state
    super || state == 'bad'
  end
end
