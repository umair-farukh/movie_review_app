require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_numericality_of(:year).only_integer.is_greater_than(0) }
  end

  describe 'associations' do
    it { should have_many(:reviews) }
    it { should belong_to(:actor) }
    it { should belong_to(:director) }
  end
end
