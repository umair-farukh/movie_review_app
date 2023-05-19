require 'rails_helper'

RSpec.describe Movies::Create, type: :service do
  describe '#call' do
    let(:params) do
      {
        title: 'Captain America',
        description: 'An example movie',
        year: 2022,
        director: director.name,
        actor: actor.name,
        country: 'US'
      }
    end

    let(:director) { create(:director, name: 'Christopher Nolan') }
    let(:actor) { create(:actor, name: 'Leonardo DiCaprio') }
    let(:params_for_factory) do
      {
        title: 'Captain America',
        description: 'An example movie',
        year: 2022,
        director: director,
        actor: actor,
        country: 'US'
      }
    end

    context 'when movie does not exist' do
      it 'creates a new movie' do
        expect do
          described_class.new(params).call
        end.to change(Movie, :count).by(1)
      end

      it 'returns the created movie' do
        movie = described_class.new(params).call
        expect(movie).to be_a(Movie)
        expect(movie.title).to eq('Captain America')
      end
    end

    context 'when movie already exists' do
      let!(:movie) { create(:movie, params_for_factory) }

      it 'does not create a new movie' do
        expect do
          described_class.new(params).call
        end.not_to change(Movie, :count)
      end

      it 'returns the existing movie' do
        result = described_class.new(params).call
        expect(result).to eq(movie)
      end
    end

    context 'when an error occurs' do
      it 'logs the error and returns nil' do
        allow(Rails.logger).to receive(:error)
        allow(Movie).to receive(:find_or_create_by).and_raise(StandardError, 'Something went wrong')

        result = described_class.new(params).call

        expect(result).to be_nil
        expect(Rails.logger).to have_received(:error).with('Error creating movie: Something went wrong')
      end
    end
  end
end
