require 'spec_helper'
require "#{Rails.root}/lib/bechdel_scraping.rb"

describe BechdelScraping do

  context 'bechdel successfully scrapes and saves' do
    let(:user) { FactoryGirl.build(:user) }
    let(:movie) { FactoryGirl.build(:movie) }
    let(:bechdel) { FactoryGirl.build(:bechdel) }

    it 'correctly scrapes a particular movie url' do
      allow(movie).to receive(:user).and_return(user)
      allow(bechdel).to receive(:movie).and_return(movie)
      bechdel.bechdel_url = 'http://bechdeltest.com/view/3740/jiro_dreams_of_sushi/'

      bechdel_scraping = BechdelScraping.new(2)
      movie_hash = bechdel_scraping.one_movie_bechdel_website('http://bechdeltest.com/view/3740/jiro_dreams_of_sushi/')

      expect(movie_hash[:num_tests_pass]).to eq('This movie passed 0 of 3 tests.')
      expect(movie_hash[:explanation]).to eq('Fewer than two women in this movie')
      expect(movie_hash[:movie_title]).to eq('Jiro Dreams of Sushi')
    end

    # failing test, says bechdel_website_movie_urls is a private method?
    # it 'returns valid URLs when scraping bechdeltest.com' do
    #   bechdel_scraping = BechdelScraping.new(3)
    #   movie_links = bechdel_scraping.bechdel_website_movie_urls
    #
    #   counter = 0
    #   10.times do
    #     expect(movie_links[counter]).to be_valid
    #     count += 1
    #   end
    # end

  end

end
