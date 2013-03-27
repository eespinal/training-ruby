module Training
  class Movie

    attr_accessor :title, :date_published, :genre, :production_studio, :rating

    def initialize(title, date_published, genre, production_studio, rating)
      @title = title
      @date_published = date_published
      @genre = genre
      @production_studio = production_studio
      @rating = rating
    end

    def published_between?(start_year, end_year)
      date_published.year >= start_year && date_published.year <= end_year
    end

    def to_s
      "#{title} (#{date_published.year}) - #{genre} | #{production_studio}"
    end

    def ==(other)
      title == other.title
    end

    def <=>(other)
      title <=> other.title
    end

  end

end
