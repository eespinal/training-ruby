module Training
  module Helpers
    class Mock
      def self.for_movie(name)
        Movie.new(name, nil, nil, nil, nil)
      end
    end
  end
end