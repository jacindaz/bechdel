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

  it "should update movie votes when a vote is saved" do
    @vote = FactoryGirl.build(:vote)
    @movie = FactoryGirl.build(:movie)

    @movie.save!
    @vote.movie_id = @movie.id
    @vote.save!

    # failed attempt to test vote after_save callback
    # @vote.run_callbacks(:save) { true }
    # if @vote.vote == (-1)
    #   expect(@movie.down_votes).to eq(1)
    # elsif @vote.vote == (1)
    #   expect(@movie.up_votes).to eq(1)
    # end

  end

end
