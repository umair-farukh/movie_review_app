require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'GET #index' do
    let(:actor) { create(:actor, name: 'Nicolas Cage') }
    let(:actor2) { create(:actor, name: 'Ellen Page') }

    context 'without actor parameter' do
      it 'assigns all movies' do
        movie1 = create(:movie)
        movie2 = create(:movie)

        get :index

        expect(assigns(:movies)).to match_array([movie1, movie2])
      end
    end

    it 'resets the actor parameter if reset is present' do
      get :index, params: { reset: true, actor: actor }

      expect(assigns(:actor)).to be_nil
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end
  end
end
