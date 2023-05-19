# Movie Review App

Welcome to the Movie Review App! This application allows users to browse and review movies.

## Assumptions

- Duplicate movie and review records are not allowed in the database. To handle this, the application uses the `find_or_create_by` method when importing movies and reviews from the CSV files. This ensures that duplicate records are not created.

- The application assumes that the number of records to be imported is relatively small. As a result, the import functionality does not use a background job or import data in batches. If there is a need to import a large number of records in the future, it is recommended to convert the import functionality into an Active Job or utilize a background processing framework such as Sidekiq.

- The CSV files (`movies.csv` and `reviews.csv`) can be modified to include the IDs of movies in the reviews CSV. This allows for proper association between movies and reviews during the import process.

## Features

- View a list of movies
- Filter movies by actor
- Import movies from a csv
- Import review from a csv

## Prerequisites

- Ruby 3.0.0
- Rails 7.0.4
- PostgreSQL

## Import CSV
You can place the csv files in public folder and import it by running a rake task.
```
$ rails import_csv:movies_and_reviews 
```
