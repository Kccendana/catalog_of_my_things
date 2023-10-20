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
    7 => { label: 'list all labels ', action: :list_all_labels },
    8 => { label: 'add book ', action: :add_book },
    9 => { label: 'add music Album ', action: :add_music_album },
    10 => { label: 'add games ', action: :add_games },
    11 => { label: 'add genre ', action: :add_genre },
    12 => { label: 'add labels ', action: :add_label },
    13 => { label: 'Quit ', action: :quit }
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
    (1..13).include?(choice)
  end

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
    print 'Enter Label title :'
    title = gets.chomp
    label_title = @catalog_management.labels.find { |label| label.title == title }
    if label_title.nil?
      print 'Enter the Label Color: '
      color = gets.chomp
      new_label = Label.new(title, color)
      @catalog_management.add_label(new_label)
      @catalog_management.save_label
      puts "\n#{GREEN} Label added successfully!"
      title = new_label.title
    end
    published_date = date_of_publish
    cover_state = add_cover_state
    book = Book.new(title, published_date, cover_state)
    @catalog_management.add_book(book)
    @catalog_management.save_books
    puts "\n#{GREEN} Book added successfully!"
  end

  def add_label
    puts "\nAdding label"
    print 'Enter title : '
    title = gets.chomp
    print 'Enter label color : '
    color = gets.chomp
    if @catalog_management.labels.any? { |label| label.title == title }
      puts "\n#{RED} Label named #{title} exist!"
    else
      label = Label.new(title, color)
      @catalog_management.add_label(label)
      @catalog_management.save_label
      puts "\n#{GREEN} Label added successfully!"
    end
  end

  def list_all_books
    puts "\nList of All Books:"
    if @catalog_management.books.empty?
      puts 'No book in the catalog.'
    else
      @catalog_management.books.each_with_index do |book, index|
        puts "#{index + 1}. Book Title : #{book.label}" # Display the label's title
        puts "   Published Date : #{book.published_date}"
        puts "   Cover State: #{book.cover_state}"
        puts "   Can be archived: #{book.archived}"
      end
    end
  end

  def list_all_labels
    puts "\nList of All Labels:"
    if @catalog_management.labels.empty?
      puts 'No Label Title in the catalog.'
    else
      @catalog_management.labels.each_with_index do |label, index|
        puts "#{index + 1}. Title: #{label.title}"
        puts "   Color: #{label.color}"
      end
    end
  end

  def quit
    puts "\n#{RED}Thank you visiting Catalog, Good bye.."
    exit
  end
end
