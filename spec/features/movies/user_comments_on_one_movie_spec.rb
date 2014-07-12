require 'rails_helper'

feature 'user writes a comment on a particular movie' do

  context 'as an authenticated user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in(user)
    end

    scenario 'user writes a comment on a movie' do
      comment = FactoryGirl.create(:comment)
      visit movie_path(comment.movie)

      fill_in "comment[:body]", with: comment.body
      click_on "Submit"
      expect(page).to have_content "Comment saved."
      expect(page).to have_content comment.body
    end

    scenario 'user submits an empty comment' do
    end

  end
end
