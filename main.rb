require_relative 'inc_helper'

catalog_management = Catalog_management.new

menu = Menu.new(catalog_management)

loop do
  menu.display_menu
  choice = gets.chomp.to_i

  if menu.valid_choice?(choice)
    menu.handle_choice(choice)
  else
    puts 'Invalid choice. Please choose a valid option.'
  end

  break if choice == 10
end