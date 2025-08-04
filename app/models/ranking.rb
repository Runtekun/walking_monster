class Ranking < ApplicationRecord
  belongs_to :user

  validates :rank, :score, :category, :recorded_at, presence: true

  scope :by_category_and_date, ->(category, date) {
    where(category: category, recorded_at: date.beginning_of_day..date.end_of_day)
  }
end
