module PogoPlug
  class FileListing
    include HashInitializer

    attr_accessor :size, :offset, :total_count, :files

    def files
      @files ||= Array.new
    end

    def self.from_json(json)
      listing = FileListing.new(
        size: json['count'].to_i,
        offset: json['pageoffset'].to_i,
        total_count: json['totalcount'].to_i
      )
      json['files'].each do |f|
        listing.files << File.from_json(f)
      end
      listing
    end
  end
end
