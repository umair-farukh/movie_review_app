module Reviews
  class Create
    def initialize(params)
      @movie_id = params[:movie_id]
      @user_name = params[:user]
      @stars = convert_to_integer(params[:stars])
      @review = params[:review]
    end

    def call
      begin
        user = Users::FindOrCreateByField.new(:name, @user_name).call
        review = Review.find_or_create_by(movie_id: @movie_id, user: user) do |rev|
          rev.stars = @stars
          rev.review = @review
        end
        review
      rescue StandardError => e
        log_error(e)
        nil
      end
    end

    private

    def convert_to_integer(value)
      value.to_i if value.present?
    end

    def log_error(error)
      Rails.logger.error("Error creating review: #{error.message}")
    end
  end
end
