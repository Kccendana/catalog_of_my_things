require_relative 'inc_helper'

class Book < Items
  attr_accessor :cover_state
  attr_reader :id

  def initialize(published_date, cover_state)
    super(published_date)
    @cover_state = cover_state
  end

  def to_hash
    { 'id' => @id,
      'published_date' => @published_date,
      'cover_state' => @cover_state,
      'can_be_archived' => @can_be_archived }
  end

  def self.from_json(json_str)
    data = JSON.parse(json_str)
    new(BookParams.new(data['published_date'],
                       data['cover_state'],
                       data['can_be_archived']))
  end

  def can_be_archived?
    state = @cover_state
    super || state == 'bad'
  end
end
