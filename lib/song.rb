class Song

    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        if artist
            self.artist = artist
        end
        if genre
            self.genre = genre
        end
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        if genre.songs.include?(self) != true
            genre.songs << self
        end
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        new_song = Song.new(name)
        new_song.save
        new_song
    end

    def self.find_by_name(name)
        self.all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        if self.find_by_name(name)
            self.find_by_name(name)
        else
            self.create(name)
        end
    end

    def self.new_from_filename(filename)
        song_name = filename.split(" - ")[1]  #gets song name string
        artist_name = filename.split(" - ")[0] # gets artist name string
        genre_name = filename.split(" - ")[2].gsub(".mp3", "") # gets genre name string, removes the .mp3

        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)

        new_song = Song.new(song_name, artist, genre)
    end

    def self.create_from_filename(filename)
        new_song = self.new_from_filename(filename)
        new_song.save
    end

end