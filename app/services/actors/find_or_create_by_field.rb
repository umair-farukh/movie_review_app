module Actors
  class FindOrCreateByField
    def initialize(field, value)
      @field = field
      @value = value
    end

    def call
      Actor.find_or_create_by(@field => @value)
    rescue StandardError => e
      log_error(e)
      nil
    end

    private

    def log_error(error)
      Rails.logger.error("Error finding user by field: #{error.message}")
    end
  end
end
