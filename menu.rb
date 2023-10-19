require_relative 'inc_helper'

class Menu
  include GameAuthor
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
    11 => { label: 'add authors ', action: :add_author },
    12 => { label: 'Quit ', action: :quit }
  }.freeze

  def display_menu
    puts "\n#{CYAN}Catalog of my Things:"
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
      puts "\nInvalid choice, Please try again!"
    end
  end

  def valid_choice?(choice)
    (1..12).include?(choice)
  end

  def add_music_album
    puts "\nAdding Music Album"
    genre_name = use_genre_name
    genre = @catalog_management.genres.find { |g| g.name == genre_name }
    if genre.nil?
      puts "\n#{RED}Genre does not exist, creating it before adding a music album."
      genre = Genres.new(genre_name)
      @catalog_management.add_genre(genre)
      @catalog_management.save_genres_to_json('genres.json')
      puts "\n#{GREEN}Genre #{genre_name} created successfully."
    end

    print 'Enter the published date: '
    published_date = gets.chomp
    print 'Is it on Spotify? (true/false): '
    on_spotify_input = gets.chomp.downcase
    on_spotify = on_spotify_input == 'true'
    music_album = MusicAlbum.new(genre, published_date, on_spotify)
    @catalog_management.add_music_album(music_album)
    @catalog_management.save_items_to_json('music_albums.json')
    puts "\n#{GREEN}Music Album added successfully!"
  end

  def use_genre_name
    print 'Enter the Genre name: '
    gets.chomp
  end

  def add_genre
    puts "\nAdding a Genre"
    print 'Enter the name of the Genre: '
    genre_name = gets.chomp

    if @catalog_management.genres.any? { |g| g.name == genre_name }
      puts "#{RED} Genre #{genre_name} is already exist."
    else
      genre = Genres.new(genre_name)
      @catalog_management.add_genre(genre)

      @catalog_management.save_genres_to_json('genres.json')
      puts "\n #{GREEN} Genres are successfully created!"
    end
  end

  def add_games
    puts "\nAdding New Game"
    author_fname = use_author_fname
    author_lname = use_author_lname
    author = @catalog_management.authors.find { |a| (a.fname == author_fname && a.lname == author_lname) }
    if author.nil?
      puts "\nAuthor does not exist, creating it before adding a Game."
      author = Authors.new(author_fname, author_lname)
      @catalog_management.add_author(author)
      @catalog_management.save_author_to_json('authors.json')
      puts "\nAuthor #{author_fname}- #{author_lname} created successfully."
    end
    published_date = use_published_date
    multiplayer = use_multiplayer
    last_played_at = use_play_at
    games = Games.new(author, published_date, multiplayer, last_played_at)
    @catalog_management.add_games(games)
    @catalog_management.save_games_to_json('games.json')
    puts "\nGame added successfully!"
  end

  def use_author_fname
    print 'Enter the First name: '
    gets.chomp
  end

  def use_author_lname
    print 'Enter the Last name: '
    gets.chomp
  end

  def use_multiplayer
    print 'Is it Multiplayer? (true/false): '
    gets.chomp.downcase
  end

  def use_play_at
    print 'Enter the last played at: '
    gets.chomp
  end

  def use_published_date
    print 'Enter the published date: '
    gets.chomp
  end

  def quit
    puts "\n#{RED}Thank you for visiting Catalog. Goodbye!"
    exit
  end
end
