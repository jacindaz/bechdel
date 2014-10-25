require 'rails_helper'

describe Bechdel do

  # associations
  it { should belong_to(:movie) }

  # validations
  it { should validate_uniqueness_of(:movie_id).scoped_to(:passing_tests, :bechdel_url) }
  it { should validate_presence_of(:passing_tests) }
  it { should validate_presence_of(:tests_explanation) }
  it { should validate_presence_of(:bechdel_url) }

end
