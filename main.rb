require_relative 'inc_helper'

catalog_management = CatalogManagement.new
catalog_management.load_items_from_json('music_albums.json')
catalog_management.load_genres_from_json('genres.json')
catalog_management.load_games_from_json('games.json')
catalog_management.load_authors_from_json('authors.json')

menu = Menu.new(catalog_management)

loop do
  menu.display_menu
  choice = gets.chomp.to_i

  if menu.valid_choice?(choice)
    menu.handle_choice(choice)
  else
    puts 'Invalid choice. Please choose a valid option.'
  end

  break if choice == 12
end
