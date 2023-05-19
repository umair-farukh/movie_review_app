require 'rails_helper'

RSpec.describe Movies::Fetch, type: :service do
  describe '#call' do
    let(:actor_name) { 'Leonardo DiCaprio' }
    context 'when actor is present' do
      let(:actor) { create(:actor, name: actor_name) }
      let!(:movie_with_actor) { create(:movie, actor: actor) }
      let!(:movie_without_actor) { create(:movie) }

      it 'returns movies filtered by actor' do
        service = Movies::Fetch.new(actor_name)
        result = service.call

        expect(result).to include(movie_with_actor)
        expect(result).not_to include(movie_without_actor)
      end
    end

    context 'when actor is blank' do
      let(:actor_name) { nil }
      let!(:movie1) { create(:movie) }
      let!(:movie2) { create(:movie) }

      it 'returns all movies' do
        service = Movies::Fetch.new(actor_name)
        result = service.call

        expect(result).to include(movie1, movie2)
      end
    end
  end
end
