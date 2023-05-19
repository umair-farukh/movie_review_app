class Review < ApplicationRecord
    belongs_to :movie
    belongs_to :user

    validates :stars, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }
    
end