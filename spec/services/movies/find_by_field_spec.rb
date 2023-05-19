require 'rails_helper'

RSpec.describe Movies::FindByField do
  describe '#call' do
    let(:field) { :title }
    let(:value) { 'Example Movie' }

    context 'when movie is found' do
      it 'returns the movie with the specified field and value' do
        movie = create(:movie, title: 'Example Movie')

        service = Movies::FindByField.new(field, value)
        result = service.call

        expect(result).to eq(movie)
      end
    end

    context 'when movie is not found' do
      it 'returns nil' do
        service = Movies::FindByField.new(field, value)
        result = service.call

        expect(result).to be_nil
      end
    end

    context 'when an error occurs' do
      it 'logs the error and returns nil' do
        allow(Movie).to receive(:find_by).and_raise(StandardError, 'Something went wrong')

        service = Movies::FindByField.new(field, value)

        expect(Rails.logger).to receive(:error).with(/Error finding movie by field/)
        result = service.call

        expect(result).to be_nil
      end
    end
  end
end
