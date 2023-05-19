require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    rescue_from StandardError, with: :handle_exceptions

    def index
      raise StandardError, 'Something went wrong'
    end
  end

  describe 'handling exceptions' do
    it 'logs the unhandled exception' do
      expect(Rails.logger).to receive(:error).with('Unhandled Exception: Something went wrong')

      get :index
    end

    it 'renders the error page' do
      get :index

      expect(response).to have_http_status(:internal_server_error)
      expect(response).not_to render_with_layout
    end
  end
end
