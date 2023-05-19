module Users
  class FindOrCreateByField
    def initialize(field, value)
      @field = field
      @value = value
    end

    def call
      User.find_or_create_by(@field => @value)
    rescue StandardError => e
      log_error(e)
      nil
    end

    private

    def log_error(error)
      Rails.logger.error("Error finding movie by field: #{error.message}")
    end
  end
end
