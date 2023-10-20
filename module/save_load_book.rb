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
    publisher = add_publisher
    published_date = date_of_publish
    cover_state = add_cover_state
    book = Book.new(title, publisher, published_date, cover_state)
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
        puts "#{index + 1}. Book Title : #{book.label}"
        puts "   Publisher Name : #{book.publisher}"
        puts "   Published Date : #{book.published_date}"
        puts "   Cover State: #{book.cover_state}"
        puts "   Can be archived: #{book.archived}"
      end
    end
  end

  def load_books_from_json(filename)
    if File.exist?(filename)
      begin
        json_data = File.read(filename)
        data = JSON.parse(json_data, symbolize_names: true)
        data.each do |item_data|
          books = Book.from_json(item_data.to_json)
          @books << books
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
          @labels << label
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
