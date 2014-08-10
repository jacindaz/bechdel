require 'rails_helper'

feature 'user votes on a particular movie' do

  context 'as an authenticated user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in(user)
    end

    scenario 'user votes passes a particular movie' do
      movie = FactoryGirl.create(:movie)
      visit movie_path(movie)

      click_on "Pass"
      expect(page).to have_content "Thanks for already voting on this movie!"
    end

  end
end
