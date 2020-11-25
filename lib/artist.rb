class Artist
    extend Concerns::Findable

    attr_accessor :name
    attr_reader :songs

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
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
        new_artist = Artist.new(name)
        new_artist.save
        new_artist
    end

    def add_song(song)
        if song.artist == nil
            song.artist = self
        end

        if self.songs.include?(song) != true
            @songs << song
        end
    end

    def genres
        genres = self.songs.collect {|song| song.genre}
        genres.uniq
    end

end