require_relative 'inc_helper'

catalog_management = CatalogManagement.new

catalog_management.load_books_from_json('books.json')
catalog_management.load_label_from_json('labels.json')
catalog_management.load_items_from_json('music_albums.json')
catalog_management.load_genres_from_json('genres.json')


menu = Menu.new(catalog_management)

loop do
  menu.display_menu
  choice = gets.chomp.to_i

  if menu.valid_choice?(choice)
    menu.handle_choice(choice)
  else
    puts 'Invalid choice. Please choose a valid option.'
  end

  break if choice == 13
end
