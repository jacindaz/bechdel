require 'rails_helper'

describe Vote do

  it { should belong_to(:movie) }
  it { should belong_to(:user) }

  it { should validate_numericality_of(:movie_id) }
  it { should validate_numericality_of(:user_id) }
  it do
    should ensure_inclusion_of(:vote).
      in_array([-1, 1])
  end

  it "updates movie up and down votes when saving vote" do
    movie = FactoryGirl.create(:movie)
    vote1 = FactoryGirl.create(:vote, vote: -1, movie_id: movie.id)
    vote2 = FactoryGirl.create(:vote, vote: 1, movie_id: movie.id)
    votes = [vote1, vote2]

    votes.each do |vote|
      vote.update_movie_votes
      if vote.vote == (-1)
        movie.update_votes("not")
        expect(movie.down_votes).to eq(1)
      elsif vote.vote == (1)
        movie.update_votes("pass")
        expect(movie.up_votes).to eq(1)
      end
    end
  end

end
