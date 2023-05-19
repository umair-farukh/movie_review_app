require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it { should validate_numericality_of(:stars).only_integer.is_greater_than(0).is_less_than_or_equal_to(5) }
  end

  describe 'associations' do
    it { should belong_to(:movie) }
    it { should belong_to(:user) }
  end
end
