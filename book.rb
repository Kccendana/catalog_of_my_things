require_relative 'inc_helper'

class Book < Items
  attr_accessor :cover_state, :publisher, :genre
  attr_reader :id

  BookParams = Struct.new(:genre, :author, :label, :source, :publisher, :published_date, :cover_state)

  def initialize(book_params)
    super(book_params.genre, book_params.author, book_params.label, book_params.source, book_params.published_date)
    @cover_state = book_params.cover_state
    @publisher = book_params.publisher
    @can_be_archived = can_be_archived?
  end

  def to_hash
    { 'id' => @id,
      'genre' => @genre,
      'author' => @author,
      'label' => @label,
      'source' => @source,
      'publisher' => @publisher,
      'published_date' => @published_date,
      'cover_state' => @cover_state,
      'can_be_archived' => @can_be_archived }
  end

  def self.from_json(json_str)
    data = JSON.parse(json_str)
    genre = Genres.new(data['genre'])
    new(genre,
        data['author'],
        data['label'],
        data['source'],
        data['publisher'],
        data['published_date'],
        data['cover_state'])
  end

  def can_be_archived?
    state = @cover_state
    super && ((state == 'bad') || (state == 'very bad'))
  end
end
