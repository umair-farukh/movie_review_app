class ApplicationController < ActionController::Base
    around_action :handle_exceptions
  
    private
  
    def handle_exceptions
      yield
    rescue => e
      Rails.logger.error("Unhandled Exception: #{e.message}")
      render_error_page
    end
  
    def render_error_page
      render file: "#{Rails.root}/public/500.html", layout: false, status: :internal_server_error
    end
end