class UserRankingAggregator

  # 通算（all_time）の歩数ランキングを集計する
  def self.aggregate_steps_all_time
    # ユーザーごとの合計歩数を集計（Destinationsテーブルから）
    scores = Destination.group(:user_id).sum(:steps)

    # 結果をランキングとして保存
    save_rankings(scores, 'steps', 'all_time', nil, nil)
  end

  # 1週間分の歩数ランキングを集計する（週次）
  def self.aggregate_steps_weekly
    # 集計対象の期間：先週の月曜〜日曜
    start_date = 1.week.ago.beginning_of_week.to_date
    end_date = 1.week.ago.end_of_week.to_date

    # 期間内の歩数合計をユーザーごとに集計
    scores = Destination.where(walked_at: start_date..end_date)
                        .group(:user_id)
                        .sum(:steps)

    # 結果を保存
    save_rankings(scores, 'steps', 'weekly', start_date, end_date)
  end

  # 当月の歩数ランキングを集計する（月次）
  def self.aggregate_steps_monthly
    # 今月の開始日と終了日を取得
    start_date = Date.current.beginning_of_month
    end_date = Date.current.end_of_month

    # 期間内の歩数合計をユーザーごとに集計
    scores = Destination.where(walked_at: start_date..end_date)
                        .group(:user_id)
                        .sum(:steps)

    # 結果を保存
    save_rankings(scores, 'steps', 'monthly', start_date, end_date)
  end

  # 集計されたスコア（scores）をUserRankingテーブルに保存
  def self.save_rankings(scores, category, period, start_date, end_date)
    # 同じ期間・カテゴリの既存ランキングを削除（再集計のため）
    UserRanking.where(
      ranking_category: category,
      ranking_period: period,
      period_start: start_date
    ).delete_all

    # スコアを降順（高い順）に並べ替え
    sorted = scores.sort_by { |_, score| -score }

    # 並べた順にrankを付けて1件ずつ保存
    sorted.each_with_index do |(user_id, score), index|
      UserRanking.create!(
        user_id: user_id,
        score: score,
        ranking_category: category,
        ranking_period: period,
        period_start: start_date,
        period_end: end_date,
        rank: index + 1
      )
    end
  end
end