class MusicImporter

    attr_reader :path

    def initialize(path)
        @path = path
    end

    def files 
        d = Dir.new(self.path)
        files = d.children
    end

    def import
        self.files.each {|file| Song.create_from_filename(file)}
    end

end