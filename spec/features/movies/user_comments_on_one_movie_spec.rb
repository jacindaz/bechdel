require 'rails_helper'

feature 'user writes a comment on a particular movie' do

  context 'as an authenticated user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in(user)
    end

    scenario 'user writes a comment on a movie' do
      comment = FactoryGirl.build(:comment)
      visit movie_path(comment.movie)

      binding.pry

      fill_in "comment_body", with: comment.body
      click_on "Submit"
      expect(page).to have_content "Comment saved."
      expect(page).to have_content comment.body
    end

    scenario 'user submits an empty comment' do
      movie = FactoryGirl.create(:movie)
      visit movie_path(movie)

      click_on "Submit"
      expect(page).to have_content "Unable to save comment."
    end

    scenario 'user submits a duplicate comment on the same movie.' do
      comment = FactoryGirl.create(:comment)
      visit movie_path(comment.movie)

      fill_in "comment_body", with: comment.body
      click_on "Submit"
      fill_in "comment_body", with: comment.body
      click_on "Submit"

      expect(page).to have_content "Users can only submit 1 comment per movie."
    end

  end
end
