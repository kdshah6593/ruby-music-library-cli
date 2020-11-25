class MusicLibraryController

    def initialize(path = "./db/mp3s")
        imported_music = MusicImporter.new(path)
        imported_music.import
    end

    def call
        user_input = nil
        
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"

        while user_input != 'exit'
            user_input = gets.chomp
            case user_input
            when 'list songs'
                list_songs
            when 'list artists'
                list_artists
            when 'list genres'
                list_genres
            when 'list artist'
                list_songs_by_artist
            when 'list genre'
                list_songs_by_genre
            when 'play song'
                play_song
            end
        end
    end

    def list_songs
        song_list = Song.all.sort_by { |song| song.name }
        song_list.each_with_index do |song, index|
            puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        artist_list = Artist.all.sort_by { |artist| artist.name }
        artist_list.each_with_index do |artist, index|
            puts "#{index + 1}. #{artist.name}"
        end
    end

    def list_genres
        genre_list = Genre.all.sort_by { |genre| genre.name }
        genre_list.each_with_index do |genre, index|
            puts "#{index + 1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        user_artist_input = gets.chomp

        if artist = Artist.find_by_name(user_artist_input)
            artist.songs.sort_by {|song| song.name}.each_with_index do |song, index|
                puts "#{index+1}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_genre_input = gets.chomp

        if genre = Genre.find_by_name(user_genre_input)
            genre.songs.sort_by {|song| song.name}.each_with_index do |song, index|
                puts "#{index+1}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.chomp.to_i
        num_songs = Song.all.length
        
        if input.between?(1, num_songs)
            song_list = Song.all.sort_by { |song| song.name }
            song = song_list[input-1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end

end