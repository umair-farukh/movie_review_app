module Reviews
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
                    # this will be picking up the first movie from the liat that matches with the title
                    # we should expect an Id of the movie in the reviews.csv
                    movie = Movies::FindByField.new(:title, row['Movie']).call
                    if movie.present?
                        Reviews::Create.new({
                            movie_id: movie.id,
                            user: row['User'],
                            stars: row['Stars'],
                            review: row['Review']
                        }).call
                    end
                end
            rescue StandardError => e
                Rails.logger.error("Error importing reviews: #{e.message}")
            end
        end
    end
end