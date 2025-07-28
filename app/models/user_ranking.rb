class UserRanking < ApplicationRecord
  belongs_to :user

  enum ranking_category: { steps: "steps", monster_level: "monster_level" }
  enum ranking_period: { all_time: "all_time", weekly: "weekly", monthly: "monthly" }

  validates :score, :ranking_category, :ranking_period, presence: true
end