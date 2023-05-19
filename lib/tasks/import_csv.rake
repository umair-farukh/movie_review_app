namespace :import_csv do
    desc "Import movies and reviews from CSV"
    task :movies_and_reviews => :environment do
        movies_file_path = Rails.root.join("public", "movies.csv")
        reviews_file_path = Rails.root.join("public", "reviews.csv")
        Movies::Import.new(movies_file_path).call
        Reviews::Import.new(reviews_file_path).call
        puts "Import completed."
    end
end