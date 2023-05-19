class Movie < ApplicationRecord
    has_many :reviews
    belongs_to :actor
    belongs_to :director

    validates :title, presence: true
    validates :year, numericality: { only_integer: true, greater_than: 0 }

    def average_rating
        reviews.average(:stars)&.to_f || 0.0
    end
end