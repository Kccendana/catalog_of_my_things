require_relative 'inc_helper'

class Items
  attr_accessor :genre, :author, :source, :label, :published_date
  attr_reader :id, :archived

  def initialize(published_date)
    raise ArgumentError, 'Invalid published date format' unless valid_published_date?(published_date)

    @id = Random.rand(1..1000)
    @genre = nil
    @author = nil
    @source = nil
    @label = nil
    @publisher = nil
    @published_date = Date.parse(published_date)
    @archived = false
  end

  def valid_published_date?(date)
    Date.parse(date)
    true
  rescue ArgumentError
    false
  end

  def can_be_archived?
    current_time = Time.now.year
    (current_time - @published_date.year) > 10
  end

  def move_to_archived
    @archived = can_be_archived?
  end

  def to_hash
    if instance_of?(Book)
      { 'class' => self.class, 'classroom' => @classroom, 'age' => @age, 'name' => @name,
        'parent_permission' => @parent_permission, 'id' => @id }
    else
      { 'class' => self.class, 'specialization' => @specialization, 'age' => @age, 'name' => @name,
        'parent_permission' => @parent_permission, 'id' => @id }
    end
  end
end
