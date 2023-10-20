module GameAuthor
  RED = "\e[31m".freeze
  GREEN = "\e[32m".freeze
  YELLOW = "\e[33m".freeze
  BLUE = "\e[34m".freeze
  MAGENTA = "\e[35m".freeze
  CYAN = "\e[36m".freeze

  def add_author
    puts "\nAdding a Author"
    print 'Enter the First name: '
    fname = gets.chomp
    print 'Enter the Last name: '
    lname = gets.chomp
    if @catalog_management.authors.any? { |g| (g.fname == fname && g.lname == lname) }
      puts "#{RED} Author #{fname} - #{lname} is already exist."
    else
      author = Authors.new(fname, lname)
      @catalog_management.add_author(author)
      @catalog_management.save_author_to_json('authors.json')
      puts "\n #{GREEN} Author are successfully created!"
    end
  end

  def list_all_genres
    puts "\n#{MAGENTA}List of All Genres:"
    @catalog_management.genres.each do |genres|
      puts "ID: #{genres.id}, Name: #{genres.name}"
    end
  end

  def list_all_authors
    puts "\n#{MAGENTA}List of All Authors names:"
    @catalog_management.authors.each do |authors|
      puts "ID: #{authors.id}. #{authors.fname}- #{authors.lname}"
    end
  end

  def list_all_music_albums
    puts "\n#{MAGENTA}List of All Music Albums:"
    if @catalog_management.items.empty?
      puts 'No music albums in the catalog.'
    else
      @catalog_management.items.each_with_index do |music_album, index|
        puts "#{index + 1}. Genre Name: #{music_album.genre.name}"
        puts "   Published Date: #{music_album.published_date}"
        puts "   On Spotify: #{music_album.on_spotify ? 'Yes' : 'No'}"
      end
    end
  end

  def list_all_games
    puts "\n#{MAGENTA}List of All Games:"
    if @catalog_management.games.empty?
      puts 'No Games in the catalog.'
    else
      @catalog_management.games.each_with_index do |games, index|
        puts "#{index + 1}. Author: #{games.author.fname}- #{games.author.lname}"
        puts "   Published Date: #{games.published_date}"
        puts "   Multiplayer: #{games.multiplayer}"
        puts "   last Played at: #{games.last_played_at}"
      end
    end
  end
end
