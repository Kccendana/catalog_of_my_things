# require_relative 'inc_helper'

# class Games < Items
#   attr_accessor :multiplayer, :last_played_at, :author
#   attr_reader :id

#   def initialize(author, published_date, multiplayer, last_player_at)
#     super(published_date)
#     raise ArgumentError, 'Invalid last played at date format' unless valid_played_at_date?(last_played_at)
#     @id = Random.rand(1..10000)
#     @author = author
#     @multiplayer = multiplayer
#     @last_played_at = Date.parse(last_played_at)
#   end

#   def valid_played_at_date?(date)
#     Date.parse(date)
#     true
#   rescue ArgumentError
#     false
#   end

#   def can_be_archived?
#     super && (Time.now.year - @last_played_at.year) > 2
#   end

#   def to_json(*_args)
#     {
#       'id' => @id,
#       'author' => @author.fname,
#       'published_date' => @published_date.to_s,
#       'multiplayer' => @multiplayer,
#       'last_played_at' => @last_played_at.to_s
#     }.to_json
#   end

#   def self.from_json(json_str)
#     data = JSON.parse(json_str)
#     author = Authors.new(data['author'])
#     new(author, data['published_date'], date['multiplayer'], data['last_played_at'])
#   end
# end


require_relative 'inc_helper'

class Games < Items
  attr_accessor :multiplayer, :last_played_at, :author
  attr_reader :id

  def initialize(author, published_date, multiplayer, last_played_at)
    super(published_date)
    raise ArgumentError, 'Invalid last played at date format' unless valid_played_at_date?(last_played_at)

    @id = Random.rand(1..10_000)
    @author = author
    @multiplayer = multiplayer
    @last_played_at = Date.parse(last_played_at)
  rescue ArgumentError
    raise ArgumentError, 'Invalid last played at date format'
  end

  def valid_played_at_date?(date)
    Date.parse(date)
    true
  rescue ArgumentError
    false
  end

  def can_be_archived?
    super && (Time.now.year - @last_played_at.year) > 2
  end

  def to_json(*_args)
    {
      'id' => @id,
      'author_fname' => @author.fname,
      'author_lname' => @author.lname,
      'published_date' => @published_date.to_s,
      'multiplayer' => @multiplayer,
      'last_played_at' => @last_played_at.to_s
    }.to_json
  end

  def self.from_json(json_str)
    data = JSON.parse(json_str)
    author = Authors.new(data['author_fname'], data['author_lname'])
    new(author, data['published_date'], data['multiplayer'], data['last_played_at'])
  end
end
