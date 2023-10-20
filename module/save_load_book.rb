module SaveLoadBook
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
      puts "\nLabel added successfully!"
      title = new_label.title
    end
    published_date = date_of_publish
    cover_state = add_cover_state
    book = Book.new(title, published_date, cover_state)
    @catalog_management.add_book(book)
    @catalog_management.save_books
    puts "\n Book added successfully!"
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
end
