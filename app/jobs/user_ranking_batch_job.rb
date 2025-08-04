class UserRankingBatchJob < ApplicationJob
  queue_as :default

  def perform(*args)
    UserRankingAggregator.aggregate_steps_all_time
    UserRankingAggregator.aggregate_steps_weekly
    UserRankingAggregator.aggregate_steps_monthly
  end
end
