require 'rails_helper'

feature 'user views a list of movies' do

  scenario 'user views a list of movies' do
    movie = FactoryGirl.create(:movie)

    visit movie_path(movie)
    expect(page).to have_content movie.title
    expect(page).to have_content movie.year
    expect(page).to have_content movie.summary
    expect(page).to have_content movie.language
    expect(page).to have_content movie.country_produced
  end

end
