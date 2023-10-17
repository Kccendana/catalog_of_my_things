
require_relative 'inc_helper'
class Items

  attr_accessor :genre, :author, :source, :lebel, :published_date
  attr_reader :id, :archived

  def initialize(genre, author, lebel, source, published_date)
    if valid_published_date?(published_date)
      @id = Random.rand(1..1000)
      @genre = genre
      @author = author
      @source = source
      @lebel = lebel
      @published_date = Date.parse(published_date)
      @archived = false
    else
      raise ArgumentError, 'Invalid published date format'
    end
  end

  def valid_published_date?(date)
    begin
      Date.parse(date)
      return true
    rescue ArgumentError
      return false
    end
  end

  def can_be_archived?
    currentTime = Time.now.year
    (currentTime - @published_date.year) > 10
  end

  def move_to_archived
    @archived = can_be_archived?
  end

end