require 'rails_helper'

feature 'user writes a comment on a particular movie' do

  context 'as an authenticated user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in(user)
    end

  scenario 'user writes a comment on a movie' do
    movie =
  end

  scenario 'user submits an empty comment' do
  end

end
