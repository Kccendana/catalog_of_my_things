require_relative 'inc_helper'

class Menu
  include AddItemDetails
  # Customization of console color
  RED = "\e[31m".freeze
  GREEN = "\e[32m".freeze
  YELLOW = "\e[33m".freeze
  BLUE = "\e[34m".freeze
  MAGENTA = "\e[35m".freeze
  CYAN = "\e[36m".freeze

  def initialize(catalog_management)
    @catalog_management = catalog_management
  end

  MENU_OPTIONS = {
    1 => { label: 'List all books', action: :list_all_books },
    2 => { label: 'List all music Album', action: :list_all_music_albums },
    3 => { label: 'list all games', action: :list_all_games },
    4 => { label: 'list all source', action: :list_all_sources },
    5 => { label: 'list all genres', action: :list_all_genres },
    6 => { label: 'list all authors ', action: :list_all_authors },
    7 => { label: 'add book ', action: :add_book },
    8 => { label: 'add music Album ', action: :add_music_album },
    9 => { label: 'add games ', action: :add_games },
    10 => { label: 'add genre ', action: :add_genre },
    11 => { label: 'Quit ', action: :quit }
  }.freeze

  def display_menu
    puts "\n #{CYAN}Catalog of my Things: "
    MENU_OPTIONS.each do |key, value|
      puts "#{YELLOW} #{key}. #{value[:label]}"
    end
    print "\n#{CYAN}Enter your choice: "
  end

  def handle_choice(choice)
    if MENU_OPTIONS.key?(choice)
      action = MENU_OPTIONS[choice][:action]
      send(action)
    else
      puts "\nInnvalid choice, Please try again !."
    end
  end

  def valid_choice?(choice)
    (1..11).include?(choice)
  end

  # def add_music_album
  #   puts "\nAdding Music Album"

  #   print 'Enter the author: '
  #   author = gets.chomp
  #   print 'Enter the label: '
  #   label = gets.chomp
  #   print 'Enter the source: '
  #   source = gets.chomp
  #   print 'Enter the published date: '
  #   published_date = gets.chomp
  #   print 'Is it on Spotify? (true/false): '
  #   on_spotify = gets.chomp.downcase == 'true'

  #   music_album = Music_album.new(genre, author, label, source, published_date, on_spotify)
  #   @catalog_management.add_music_album(music_album)

  #   puts "\n#{GREEN}Music Album added successfully!"
  # end

  # def add_genre
  #   puts "\nAdding a Genre"
  #   print 'Enter the name of the Genre: '
  #   genre_name = gets.chomp

  #   if @catalog_management.genres.any? { |g| g.name == genre_name }
  #     puts "#{RED} Genre #{genre_name} is already exist."
  #   else
  #     genre = Genres.new(genre_name)
  #     @catalog_management.add_genre(genre)
  #     puts "\n #{GREEN} Genres is successfuly created !."
  #   end
  # end

  def list_all_genres
    @catalog_management.genres.each do |genres|
      puts "ID: #{genres.id}, Name: #{genres.name}"
    end
  end

  def list_all_music_albums
    puts "\nList of All Music Albums:"
    if @catalog_management.items.empty?
      puts 'No music albums in the catalog.'
    else
      @catalog_management.items.each_with_index do |music_album, index|
        puts "#{index + 1}. Title: #{music_album.label}"
        puts "   Genre: #{music_album.genre.name}"
        puts "   Author: #{music_album.author}"
        puts "   Source: #{music_album.source}"
        puts "   Published Date: #{music_album.published_date}"
        puts "   On Spotify: #{music_album.on_spotify ? 'Yes' : 'No'}"
      end
    end
  end

  def add_book
    puts "\nAdding Books"
    published_date = date_of_publish
    cover_state = add_cover_state
    book = Book.new(published_date, cover_state)
    @catalog_management.add_book(book)

    puts "\n#{GREEN} Book added successfully!"
  end

  def list_all_books
    puts "\nList of All Books:"
    if @catalog_management.items.empty?
      puts 'No book in the catalog.'
    else
      @catalog_management.items.each_with_index do |book, index|
        puts "#{index + 1}. Title: #{book.label}"
        puts "   Genre: #{book.genre.name}"
        puts "   Author: #{book.author}"
        puts "   Source: #{book.source}"
        puts "   Published Date: #{book.published_date}"
        puts "   Cover State: #{book.cover_state ? 'Good' : 'Bad'}"
      end
    end
  end

  def quit
    puts "\n#{RED}Thank you visiting Catalog, Good bye.."
    exit
  end
end
