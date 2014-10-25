require 'rails_helper'

describe Category do

  it { should belong_to(:movie) }
  it { should validate_uniqueness_of(:movie_id).scoped_to(:category) }
  it { should validate_presence_of(:category) }

end
