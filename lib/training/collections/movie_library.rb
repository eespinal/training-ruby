module Training
  class MovieLibrary

    attr_accessor :movie_collection

    def initialize(movie_collection)
      @movie_collection = movie_collection
    end

    def add_all(*movies)
      movies.each { |m| @movie_collection << m }
    end

    def add(movie)
      @movie_collection << movie unless @movie_collection.include?(movie)
    end

    def length
      @movie_collection.length
    end

    def all_movies
      @movie_collection
    end

    def all_movies_published_by_pixar
      @movie_collection.select { |m| m.production_studio == ProductionStudio::PIXAR }
    end

    def all_movies_published_by_pixar_or_disney 
      @movie_collection.select { |m| m.production_studio == ProductionStudio::PIXAR || m.production_studio == ProductionStudio::DISNEY}
    end

    def all_movies_not_published_by_pixar 
      @movie_collection.reject { |m| m.production_studio == ProductionStudio::PIXAR }
    end

    def all_movies_published_after(year)
      @movie_collection.select { |m| m.date_published.year > year }
    end

    def all_movies_published_between_years(start_year, end_year)
      @movie_collection.select do |m| 
        year_published = m.date_published.year
        year_published >= start_year && year_published <= end_year
      end
    end

    def all_kids_movies 
      all_matching(:genre => Genre::KIDS)
    end

    def all_action_movies
      all_matching(:genre => Genre::ACTION)
    end

    def all_matching(criteria)
      matcher = build_matcher_from(criteria)
      @movie_collection.select { |m| matcher.call(m) }
    end

    def sort_all_movies_by_title_descending
      sort_all_movies_by_title_ascending.reverse
    end

    def sort_all_movies_by_title_ascending
      @movie_collection.sort { |x, y| x.title <=> y.title }
    end

    def sort_all_movies_by_date_published_descending
      sort_all_movies_by_date_published_ascending.reverse
    end

    def sort_all_movies_by_date_published_ascending
      @movie_collection.sort { |x, y| x.date_published <=> y.date_published }
    end

    def sort_all_movies_by_studio_rating_and_year_published

    end

    def build_matcher_from(criteria)
      property = criteria.keys[0]
      lambda { |entity| entity.send(property) == criteria[property] }
    end

  end
end
