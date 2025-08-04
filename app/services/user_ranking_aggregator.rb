class UserRankingAggregator
  class << self
    # 通算（all_time）の歩数ランキングを集計する
    def aggregate_steps_all_time
      scores = Destination.group(:user_id).sum(:steps)
      save_rankings(scores, "steps", "all_time", nil, nil)
    end

    # 1週間分の歩数ランキングを集計する（週次：前週の月〜日）
    def aggregate_steps_weekly
      start_date = 1.week.ago.beginning_of_week.to_date
      end_date = 1.week.ago.end_of_week.to_date

      scores = Destination.where(walked_at: start_date.beginning_of_day..end_date.end_of_day)
                          .group(:user_id)
                          .sum(:steps)

      save_rankings(scores, "steps", "weekly", start_date, end_date)
    end

    # 月次歩数ランキングを集計する（今月の1日〜末日）
    def aggregate_steps_monthly
      start_date = Date.current.beginning_of_month
      end_date = Date.current.end_of_month

      scores = Destination.where(walked_at: start_date.beginning_of_day..end_date.end_of_day)
                          .group(:user_id)
                          .sum(:steps)

      save_rankings(scores, "steps", "monthly", start_date, end_date)
    end

    # 共通処理：UserRankingとRankingに保存
    def save_rankings(scores, category, period, start_date, end_date)
      # 不要なランキングを削除（通算 or 期間付きで分岐）
      if start_date.present? && end_date.present?
        UserRanking.where(
          ranking_category: category,
          ranking_period: period
        ).where(
          period_start: start_date..start_date
        ).delete_all
      else
        UserRanking.where(
          ranking_category: category,
          ranking_period: period,
          period_start: nil,
          period_end: nil
        ).delete_all
      end

      # スコア0のユーザーは除外して降順にソート
      sorted = scores.to_a.reject { |_, score| score.to_i <= 0 }
                          .sort_by { |_, score| -score }

      sorted.each_with_index do |(user_id, score), index|
        # ① 最新状態の保存（UserRanking）
        UserRanking.create!(
          user_id: user_id,
          score: score,
          ranking_category: category,
          ranking_period: period,
          period_start: start_date,
          period_end: end_date,
          rank: index + 1
        )

        # ② 履歴保存（Ranking）
        Ranking.create!(
          user_id: user_id,
          score: score,
          rank: index + 1,
          category: "#{category}_#{period}",  # 例: steps_weekly
          recorded_at: Time.current.beginning_of_day
        )
      end
    end
  end
end
