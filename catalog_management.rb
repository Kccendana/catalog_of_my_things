require_relative 'inc_helper'
require 'json'

class CatalogManagement
  attr_accessor :items, :genres, :books, :labels

  def initialize
    @items = []
    @genres = []
    @labels = []
    @books = []
  end

  def add_music_album(music_album)
    @items << music_album
  end

  def add_book(book)
    @books << book
    write_book(@books)
  end

  def add_genre(genre)
    @genres << genre
  end

  def add_label(label)
    @labels << label
  end

  def load_items_from_json(filename)
    if File.exist?(filename)
      begin
        json_data = File.read(filename)
        data = JSON.parse(json_data, symbolize_names: true)
        data.each do |item_data|
          music_album = MusicAlbum.from_json(item_data.to_json)
          @items << music_album
        end
      rescue StandardError => e
        puts "Failed to load data from #{filename}: #{e.message}"
      end
    else
      puts "File '#{filename}' does not exist. Creating an empty file."
      File.write(filename, '[]')
    end
  end

  def load_genres_from_json(filename)
    if File.exist?(filename)
      begin
        json_data = File.read(filename)
        data = JSON.parse(json_data, symbolize_names: true)
        data.each do |genre_data|
          genre = Genres.from_json(genre_data.to_json)
          @genres << genre
        end
      rescue StandardError => e
        puts "Failed to load data from #{filename}: #{e.message}"
      end
    else
      puts "File '#{filename}' does not exist. Creating an empty file."
      File.write(filename, '[]')
    end
  end

  def save_items_to_json(filename)
    data = @items.map(&:to_json)
    begin
      File.open(filename, 'w') do |file|
        file.write("[\n")
        file.write(data.join(",\n"))
        file.write("\n]")
      end
      puts "Music Albums saved to #{filename} successfully."
    rescue StandardError => e
      puts "Failed to save Music Albums to #{filename}: #{e.message}"
    end
  end

  def save_genres_to_json(filename)
    data = @genres.map(&:to_json)
    begin
      File.open(filename, 'w') do |file|
        file.write("[\n")
        file.write(data.join(",\n"))
        file.write("\n]")
      end
      puts "Genres saved to #{filename} successfully."
    rescue StandardError => e
      puts "Failed to save Genres to #{filename}: #{e.message}"
    end
  end

  def write_book(books)
    file = File.open('books.json', 'w+')

    book_hash = {}
    books.each_with_index do |book, index|
      book_hash[(index + 1).to_s] =
        { 'id' => book.id,
          'genre' => book.genre || nil,
          'author' => book.author || nil,
          'source' => book.source || nil,
          'published_date' => book.published_date.to_s || nil,
          'cover_state' => book.cover_state,
          'archived' => book.archived }
    end
    file.write(JSON.pretty_generate(book_hash))
  end

  def save_books
    books_hashes = @items.map(&:to_hash)
    books_json = JSON.pretty_generate(books_hashes)
    File.write('books.json', books_json)
  end

  def load_books_from_json(filename)
    if File.exist?(filename)
      begin
        json_data = File.read(filename)
        data = JSON.parse(json_data, symbolize_names: true)
        data.each do |item_data|
          books = Book.from_json(item_data.to_json)
          @items << books
        end
      rescue StandardError => e
        puts "Failed to load data from #{filename}: #{e.message}"
      end
    else
      puts "File '#{filename}' does not exist. Creating an empty file."
      File.write(filename, '[]')
    end
  end

  def load_label_from_json(filename)
    if File.exist?(filename)
      begin
        json_data = File.read(filename)
        data = JSON.parse(json_data, symbolize_names: true)
        data.each do |genre_data|
          label = Label.from_json(genre_data.to_json)
          @genres << label
        end
      rescue StandardError => e
        puts "Failed to load data from #{filename}: #{e.message}"
      end
    else
      puts "File '#{filename}' does not exist. Creating an empty file."
      File.write(filename, '[]')
    end
  end
end
