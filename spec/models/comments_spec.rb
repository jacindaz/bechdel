require 'rails_helper'

describe Comment do

  # associations
  it { should belong_to(:movie) }
  it { should belong_to(:user) }

  # validations
  it { should validate_uniqueness_of(:movie_id).scoped_to(:user_id) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:body) }

end
