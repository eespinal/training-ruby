module Training
  class MovieLibrary

    attr_accessor :movie_collection

    def initialize(movie_collection)
      @movie_collection = movie_collection
    end

    def add_all(*movies)
      movies.each { |m| add(m) }
    end

    def add(movie)
      @movie_collection << movie unless movie_collection_has?(movie)
    end

    def movie_collection_has?(movie)
      @movie_collection.include?(movie)
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
      @movie_collection.select { |m| [ProductionStudio::PIXAR, ProductionStudio::DISNEY].include?(m.production_studio) }
    end

    def all_movies_not_published_by_pixar 
      @movie_collection.select { |m| m.production_studio != ProductionStudio::PIXAR }
    end

    def all_movies_published_after(year)
      @movie_collection.select { |m| m.date_published.year > year }
    end

    def all_movies_published_between_years(start_year, end_year)
      @movie_collection.select { |m| m.published_between?(start_year, end_year) }
    end

    def all_kids_movies
      @movie_collection.select { |m| m.genre == Genre::KIDS }
    end

    def all_action_movies
      @movie_collection.select { |m| m.genre == Genre::ACTION }
    end

    def sort_all_movies_by_title_descending
      sort_all_movies_by_title_ascending.reverse
    end

    def sort_all_movies_by_title_ascending
      @movie_collection.sort_by { |m| m.title }
    end

    def sort_all_movies_by_date_published_descending
      sort_all_movies_by_date_published_ascending.reverse
    end

    def sort_all_movies_by_date_published_ascending
      @movie_collection.sort_by { |m| m.date_published }
    end

    def sort_all_movies_by_studio_rating_and_year_published
      @movie_collection.sort do |movie, other_movie|
        studio_comparison = rated_production_studios.index(movie.production_studio) <=> rated_production_studios.index(other_movie.production_studio)
        if studio_comparison == 0
           movie.date_published.year <=> other_movie.date_published.year
        else
          studio_comparison
        end
      end
    end

    private
    def rated_production_studios
      [ProductionStudio::MGM, ProductionStudio::PIXAR, ProductionStudio::DREAMWORKS, ProductionStudio::UNIVERSAL, ProductionStudio::DISNEY]
    end

  end
end
