module Training
  class MovieLibrary

    attr_accessor :movie_collection

    def initialize(movie_collection)
      @movie_collection = movie_collection
    end

    def add_all(*movies)
    end

    def add(movie)
    end

    def movie_collection_has?(movie)
    end

    def length
    end

    def all_movies
    end

    def all_movies_published_by_pixar
    end

    def all_movies_published_by_pixar_or_disney 
    end

    def all_movies_not_published_by_pixar 
    end

    def all_movies_published_after(year)
    end

    def all_movies_published_between_years(start_year, end_year)
    end

    def all_kids_movies 
    end

    def all_action_movies
    end

    def sort_all_movies_by_title_descending
    end

    def sort_all_movies_by_title_ascending
    end

    def sort_all_movies_by_date_published_descending
    end

    def sort_all_movies_by_date_published_ascending
    end

    def sort_all_movies_by_studio_rating_and_year_published

    end

  end
end
