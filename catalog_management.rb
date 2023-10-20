require_relative 'inc_helper'
class CatalogManagement
  include SaveLoadBook
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
    save_books
  end

  def add_genre(genre)
    @genres << genre
  end

  def add_label(label)
    @labels << label
    save_label
  end

  def load_items_from_json(filename)
    if File.exist?(filename)
      begin
        json_data = File.read(filename)
        data = JSON.parse(json_data, symbolize_names: true)
        data.each do |item_data|
          music_album = MusicAlbum.from_json(item_data.to_json) # Pass a JSON string as an argument
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

  def save_books
    books_hashes = @books.map(&:to_hash)
    books_json = JSON.pretty_generate(books_hashes)
    File.write('books.json', books_json)
  end

  def save_label
    label_hashes = @labels.map(&:to_hash)
    label_json = JSON.pretty_generate(label_hashes)
    File.write('labels.json', label_json)
  end
end
