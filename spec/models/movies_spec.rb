require 'rails_helper'

describe Movie do

  # associations
  it { should belong_to(:user) }
  it { should have_one(:bechdel) }
  it { should have_one(:canne) }

  # validations
  it { should validate_uniqueness_of(:title).scoped_to(:year) }
  it { should validate_presence_of(:user_id) }

  it do
    should ensure_inclusion_of(:year).
      in_array((1900..2014).to_a)
  end

  it { should validate_presence_of(:summary) }
  it { should validate_presence_of(:language) }
  it { should validate_presence_of(:country_produced) }
  it { should validate_presence_of(:thumbnail_url) }

end
