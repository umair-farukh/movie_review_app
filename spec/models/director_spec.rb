require 'rails_helper'

RSpec.describe Director, type: :model do
  describe 'associations' do
    it { should have_many(:movies) }
  end
end
