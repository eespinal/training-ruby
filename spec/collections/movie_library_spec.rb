require 'spec_helper'
require 'date'

describe Training::MovieLibrary do

  let(:movie_collection) { [] }

  before do
    @sut = Training::MovieLibrary.new movie_collection
  end

  describe '#length' do

    before do
      movie1 = Mock.for_movie('movie1')
      movie2 = Mock.for_movie('movie2')
      @sut.add_all(movie1, movie2)
    end

    subject { @sut.length }

    it { should == 2 }

  end

  describe '#all_movies' do

    let(:first_movie) { Mock.for_movie('first_movie') }
    let(:second_movie) { Mock.for_movie('second_movie') }

    before { @sut.add_all(first_movie, second_movie) }

    subject { @sut.all_movies }

    it "should return all movies that have been added" do
      should == [first_movie, second_movie]
    end

  end

  describe '#add' do
    let(:movie) { Mock.for_movie('movie1') }

    context 'when the movie is not in the collection' do

      before { @sut.add(movie) }

      subject { @sut.movie_collection }

      it "should store the movie in the movie collection" do
        subject.should include(movie)
        subject.length == 1
      end

    end

    context 'when the movie is already in the collection' do

      before do
        @sut.movie_collection << movie
        @sut.add(movie)
      end

      subject { @sut.movie_collection }

      it "should store only one copy in the collection" do
        subject.length.should == 1
      end

    end

    context 'when adding two different copies of the same movie' do

      let(:speed_racer) { Mock.for_movie('speed_racer') }
      let(:another_copy_of_speed_racer) { Mock.for_movie('speed_racer') }

      before do
        @sut.movie_collection << speed_racer
        @sut.add(another_copy_of_speed_racer)
      end

      subject { @sut.movie_collection }

      it "should store only one copy in the collection" do
        subject.length.should == 1
      end

    end

  end

  shared_context 'searching_and_sorting_concerns' do

    before do
      populate_default_movie_set
      @sut.movie_collection = @movie_list
    end

    def populate_default_movie_set
      @indiana_jones_and_the_temple_of_doom = Training::Movie.new("Indiana Jones And The Temple Of Doom",
                                                      DateTime.new(1982, 1, 1),
                                                      Training::Genre::ACTION,
                                                      Training::ProductionStudio::UNIVERSAL,
                                                      10)
                                                       
      @cars = Training::Movie.new("Cars", DateTime.new(2004, 1, 1), Training::Genre::KIDS, Training::ProductionStudio::PIXAR, 10)
      @the_ring = Training::Movie.new("The Ring", DateTime.new(2005, 1, 1), Training::Genre::HORROR, Training::ProductionStudio::MGM, 7)
      @shrek = Training::Movie.new("Shrek", DateTime.new(2006, 5, 10), Training::Genre::KIDS, Training::ProductionStudio::DREAMWORKS, 10)
      @a_bugs_life = Training::Movie.new("A Bugs Life", DateTime.new(2000, 6, 20), Training::Genre::KIDS, Training::ProductionStudio::PIXAR, 10)
      @theres_something_about_mary = Training::Movie.new("There's Something About Mary", DateTime.new(2007, 1, 1), Training::Genre::COMEDY, Training::ProductionStudio::MGM, 5)
      @pirates_of_the_carribean = Training::Movie.new("Pirates of the Carribean", DateTime.new(2003, 1, 1), Training::Genre::ACTION,Training::ProductionStudio::DISNEY, 10)

      @movie_list = [@cars, @indiana_jones_and_the_temple_of_doom, @pirates_of_the_carribean, @a_bugs_life, @shrek, @the_ring, @theres_something_about_mary]
    end

  end

  describe '#all_movies_published_by_pixar' do
    include_context 'searching_and_sorting_concerns'

    subject { @sut.all_movies_published_by_pixar }

    it { should contain_only([@cars, @a_bugs_life]) }
  end

  describe '#all_movies_published_by_pixar_or_disney' do
    include_context 'searching_and_sorting_concerns'

    subject { @sut.all_movies_published_by_pixar_or_disney }

    it { should contain_only([@a_bugs_life, @pirates_of_the_carribean, @cars]) }
  end

  describe '#all_movies_not_published_by_pixar' do
    include_context 'searching_and_sorting_concerns'

    subject { @sut.all_movies_not_published_by_pixar }

    it { should_not contain_only([@cars, @a_bugs_life]) }
  end

  describe '#all_movies_published_after' do
    include_context 'searching_and_sorting_concerns'

    subject { @sut.all_movies_published_after(2004) }

    it { should contain_only([@the_ring, @shrek, @theres_something_about_mary]) }
  end

  describe '#all_movies_published_between_years' do
    include_context 'searching_and_sorting_concerns'

    subject { @sut.all_movies_published_between_years(1982, 2003) }

    it { should contain_only([@indiana_jones_and_the_temple_of_doom, @a_bugs_life, @pirates_of_the_carribean]) }
  end

  describe '#all_kids_movies' do
    include_context 'searching_and_sorting_concerns'

    subject { @sut.all_kids_movies }

    it { should contain_only([@a_bugs_life, @shrek, @cars]) }
  end

  describe '#all_action_movies' do
    include_context 'searching_and_sorting_concerns'

    subject { @sut.all_action_movies }

    it { should contain_only([@indiana_jones_and_the_temple_of_doom, @pirates_of_the_carribean]) }
  end

  describe '#sort_all_movies_by_title_descending' do
    include_context 'searching_and_sorting_concerns'

    subject { @sut.sort_all_movies_by_title_descending }

    it { should == [@theres_something_about_mary, @the_ring, @shrek, @pirates_of_the_carribean, @indiana_jones_and_the_temple_of_doom, @cars, @a_bugs_life] }

  end

  describe '#sort_all_movies_by_title_ascending' do
    include_context 'searching_and_sorting_concerns'

    subject { @sut.sort_all_movies_by_title_ascending }

    it { should == [@a_bugs_life, @cars, @indiana_jones_and_the_temple_of_doom, @pirates_of_the_carribean, @shrek, @the_ring, @theres_something_about_mary] }

  end

  describe '#sort_all_movies_by_date_published_descending' do
    include_context 'searching_and_sorting_concerns'

    subject { @sut.sort_all_movies_by_date_published_descending }

    it { should == [@theres_something_about_mary, @shrek, @the_ring, @cars, @pirates_of_the_carribean, @a_bugs_life, @indiana_jones_and_the_temple_of_doom] }

  end

  describe '#sort_all_movies_by_date_published_ascending' do
    include_context 'searching_and_sorting_concerns'

    subject { @sut.sort_all_movies_by_date_published_ascending }

    it { should == [@indiana_jones_and_the_temple_of_doom, @a_bugs_life, @pirates_of_the_carribean, @cars, @the_ring, @shrek, @theres_something_about_mary] }

  end

  describe '#sort_all_movies_by_studio_rating_and_year_published' do
    include_context 'searching_and_sorting_concerns'

    # Studio Ratings (highest to lowest)
    # MGM
    # Pixar
    # Dreamworks
    # Universal
    # Disney

    # should return a set of results 
    # in the collection sorted by the rating of the production studio (not the movie rating) and year published. for this exercise you need to take the studio ratings
    # into effect, which means that you first have to sort by movie studio (taking the ranking into account) and then by the
    # year published. For this test you cannot add any extra properties/fields to either the ProductionStudio or
    # Movie classes.

    subject { @sut.sort_all_movies_by_studio_rating_and_year_published }

    it { should == [@the_ring, @theres_something_about_mary, @a_bugs_life, @cars, @shrek, @indiana_jones_and_the_temple_of_doom, @pirates_of_the_carribean] }

  end

end
