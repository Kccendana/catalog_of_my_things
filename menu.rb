require_relative 'inc_helper'
class Menu

  # Customization of console color
  RED = "\e[31m"
  GREEN = "\e[32m"
  YELLOW = "\e[33m"
  BLUE = "\e[34m"
  MAGENTA = "\e[35m"
  CYAN = "\e[36m"

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
    10 => { label: 'Quit ', action: :quit },
  }.freeze

  def display_menu
    puts "\n #{CYAN}Catalog of my Things: "
    MENU_OPTIONS.each do |key, value|
      puts "#{YELLOW} #{key}. #{value[:label]}"
    end
    print "\n#{GREEN}Enter your choice: "
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
    (1..10).include?(choice)
  end

  def quit
    puts "\n#{RED}Thank you visiting Catalog, Good bye.."
    exit()
  end


end