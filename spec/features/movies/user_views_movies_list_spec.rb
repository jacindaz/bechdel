require 'rails_helper'

feature 'user views a list of movies' do

  context 'as an authenticated user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in(user)
    end

    scenario 'user views a list of movies' do
      movie = FactoryGirl.create(:movie)
      visit movies_path

      expect(page).to have_content movie.title
      expect(page).to have_content movie.year
      expect(page).to have_content movie.summary
      expect(page).to have_content movie.language
      expect(page).to have_content movie.country_produced
    end

  end

end
