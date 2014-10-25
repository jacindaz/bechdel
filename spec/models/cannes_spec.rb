require 'rails_helper'

describe Canne do

  it { should belong_to(:movie) }
  it { should validate_uniqueness_of(:cannes_url).scoped_to(:movie_id)}
  it { should validate_presence_of(:movie_id) }

end
