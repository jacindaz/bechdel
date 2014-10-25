require 'rails_helper'

describe Bechdel do

  context 'bechdel successfully saves and validates' do

    let(:movie) { FactoryGirl.build(:movie) }
    let(:sample_bechdel) { FactoryGirl.build(:bechdel, movie: movie)}
    
    before(:all) do

      #allow(sample_bechdel).to receive(:movie).and_return(movie)
    end

    it 'should create valid factories' do
      expect(sample_bechdel).to be_valid
    end

    it 'should validate' do
      expect(sample_bechdel).to belong_to(:movie)
      expect(sample_bechdel).to validate_presence_of(:passing_tests)
      expect(sample_bechdel).to validate_presence_of(:tests_explanation)
      expect(sample_bechdel).to validate_presence_of(:bechdel_url)

      expect(sample_bechdel).to validate_uniqueness_of(:movie_id).scoped_to(:passing_tests, :bechdel_url)
    end

  end

  context 'a bechdel should validate when saved' do
    let(:movie) { FactoryGirl.build(:movie) }
    let(:sample_bechdel_info_object) { FactoryGirl.build(:bechdel, )}

    it 'should properly save when a new bechdel object is created' do

    end

  end

end
