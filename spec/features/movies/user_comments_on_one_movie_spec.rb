require 'rails_helper'

feature 'user writes a comment on a particular movie' do

  context 'as an authenticated user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in(user)
    end

    scenario 'user writes a comment on a movie' do
      puts "I am in scenario 1"
      movie = FactoryGirl.create(:movie, year: 1988)
      puts "Movie: #{movie}"
      comment = FactoryGirl.create(:comment)

      puts "======================================"
      puts "Comment factory: #{comment}"
      puts "======================================"

      visit movie_path(movie)

      fill_in "comment_body", with: comment.body
      click_on "Create Comment"
      expect(page).to have_content "Comment saved."
      expect(page).to have_content comment.body
    end

    scenario 'user submits an empty comment' do
      movie = FactoryGirl.create(:movie)
      visit movie_path(movie)
      binding.pry
      click_on "Create Comment"
      expect(page).to have_content "Unable to save comment."
    end

  end
end
