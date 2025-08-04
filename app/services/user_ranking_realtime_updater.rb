class UserRankingRealtimeUpdater
  class << self
    # 全ユーザーの全ランキング期間・カテゴリをリアルタイム更新（引数なし版）
    def refresh_all_periods
      refresh_steps_all_time
      refresh_steps_weekly
      refresh_steps_monthly
      refresh_monster_level_all_time
    end

    # 単一ユーザーの全期間更新（参考用、通常は使わない）
    def refresh_all_periods_for(user)
      refresh_steps_all_time_for(user)
      refresh_steps_weekly_for(user)
      refresh_steps_monthly_for(user)
      refresh_monster_level_all_time_for(user)
    end

    # 通算歩数ランキング（全ユーザー）
    def refresh_steps_all_time
      scores = Destination.group(:user_id).sum(:steps)
      update_rankings(scores, "steps", "all_time", nil, nil)
    end

    # 週間歩数ランキング（全ユーザー）
    def refresh_steps_weekly
      start_date = Date.current.beginning_of_week
      end_date = Date.current.end_of_week

      scores = Destination.where(walked_at: start_date.beginning_of_day..end_date.end_of_day)
                          .group(:user_id)
                          .sum(:steps)

      update_rankings(scores, "steps", "weekly", start_date, end_date)
    end

    # 月間歩数ランキング（全ユーザー）
    def refresh_steps_monthly
      start_date = Date.current.beginning_of_month
      end_date = Date.current.end_of_month

      scores = Destination.where(walked_at: start_date.beginning_of_day..end_date.end_of_day)
                          .group(:user_id)
                          .sum(:steps)

      update_rankings(scores, "steps", "monthly", start_date, end_date)
    end

    # 通算モンスターLv（全ユーザー）
    def refresh_monster_level_all_time
      scores = UserMonster.group(:user_id).maximum(:level)
      scores.transform_values! { |v| v || 0 }
      update_rankings(scores, "monster_level", "all_time", nil, nil)
    end

    # === 以下、単一ユーザー用（必要なら実装） ===
    def refresh_steps_all_time_for(user)
      score = Destination.where(user_id: user.id).sum(:steps)
      update_rankings({ user.id => score }, "steps", "all_time", nil, nil)
    end

    def refresh_steps_weekly_for(user)
      start_date = Date.current.beginning_of_week
      end_date = Date.current.end_of_week

      score = Destination.where(user_id: user.id)
                         .where(walked_at: start_date.beginning_of_day..end_date.end_of_day)
                         .sum(:steps)

      update_rankings({ user.id => score }, "steps", "weekly", start_date, end_date)
    end

    def refresh_steps_monthly_for(user)
      start_date = Date.current.beginning_of_month
      end_date = Date.current.end_of_month

      score = Destination.where(user_id: user.id)
                         .where(walked_at: start_date.beginning_of_day..end_date.end_of_day)
                         .sum(:steps)

      update_rankings({ user.id => score }, "steps", "monthly", start_date, end_date)
    end

    def refresh_monster_level_all_time_for(user)
      score = UserMonster.where(user_id: user.id).maximum(:level) || 0
      update_rankings({ user.id => score }, "monster_level", "all_time", nil, nil)
    end

    private

    # ランキング更新共通処理
    def update_rankings(scores, category, period, start_date, end_date)
      # 範囲指定の有無により削除条件を使い分ける
      if start_date && end_date
        UserRanking.where(
          ranking_category: category,
          ranking_period: period,
          period_start: start_date.beginning_of_day..end_date.end_of_day,
          period_end: start_date.beginning_of_day..end_date.end_of_day
        ).delete_all
      else
        UserRanking.where(
          ranking_category: category,
          ranking_period: period,
          period_start: nil,
          period_end: nil
        ).delete_all
      end

      sorted = scores.to_a.reject { |_, score| score.to_i <= 0 }
                          .sort_by { |_, score| -score }

      sorted.each_with_index do |(user_id, score), index|
        UserRanking.create!(
          user_id: user_id,
          score: score,
          rank: index + 1,
          ranking_category: category,
          ranking_period: period,
          period_start: start_date,
          period_end: end_date
        )
      end
    end
  end
end
