module Movies
    class FindByField
      def initialize(field, value)
        @field = field
        @value = value
      end
  
      def call
        begin
          Movie.find_by(@field => @value)
        rescue StandardError => e
          log_error(e)
          nil
        end
      end
  
      private
  
      def log_error(error)
        Rails.logger.error("Error finding movie by field: #{error.message}")
      end
    end
end