module Movies
  class Create
    def initialize(params)
      @title = params[:title]
      @description = params[:description]
      @year = params[:year]
      @director_name = params[:director]
      @actor_name = params[:actor]
      @country = params[:country]
    end

    def call
      begin
        director = Directors::FindOrCreateByField.new(:name, @director_name).call
        actor = Actors::FindOrCreateByField.new(:name, @actor_name).call

        movie = Movie.find_or_create_by(
          title: @title,
          year: @year,
          country: @country,
          director: director,
          actor: actor
        ) do |m|
          m.description = @description
        end

        movie
      rescue StandardError => e
        log_error(e)
        nil
      end
    end

    private

    def log_error(error)
      Rails.logger.error("Error creating movie: #{error.message}")
    end
  end
end
