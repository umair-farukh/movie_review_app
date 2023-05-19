module Movies
    class Import
      require 'csv'
  
      def initialize(file_path)
        @file_path = file_path
      end
  
      def call
        begin
          csv_text = File.read(@file_path)
          csv = CSV.parse(csv_text, headers: true)
          csv.each do |row|
            create_movie(row)
          end
        rescue StandardError => e
          log_error(e)
        end
      end
  
      private
  
      def create_movie(row)
        Movies::Create.new(
          title: row['Movie'],
          description: row['Description'],
          year: row['Year'],
          director: row['Director'],
          actor: row['Actor'],
          country: row['Country']
        ).call
      end
  
      def log_error(error)
        Rails.logger.error("Error importing movies: #{error.message}")
      end
    end
end