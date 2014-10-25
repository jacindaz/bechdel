require 'rails_helper'

describe User do

  it { should have_many(:movies) }
  it { should have_many(:votes) }
  it { should have_many(:comments) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }

end
