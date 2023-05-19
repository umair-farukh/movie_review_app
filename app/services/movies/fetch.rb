module Movies
    class Fetch
      def initialize(actor)
        @actor = actor&.downcase
      end
  
      def call
        begin
          if reset_search?
            Movie.left_joins(:reviews, :actor)
              .group('movies.id')
              .order('AVG(reviews.stars) DESC NULLS LAST')
          else
            Movie.joins(:actor)
              .where("LOWER(actors.name) LIKE ?", "%#{@actor}%")
          end
        rescue StandardError => e
          log_error(e)
          []
        end
      end
  
      private
  
      def reset_search?
        @actor.blank?
      end
  
      def log_error(error)
        Rails.logger.error("Error fetching movies: #{error.message}")
      end
    end
end