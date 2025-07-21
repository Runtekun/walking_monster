class DashboardController < ApplicationController

 def show
    # ランキング
    @walking_ranking = User
      .joins(:destinations)
      .where(destinations: { walked_at: Time.zone.today.beginning_of_week..Time.zone.today.end_of_week })
      .group('users.id')
      .select('users.*, SUM(CAST(destinations.distance AS float)) AS total_distance')
      .order('total_distance DESC')
      .limit(10)

    @user_monster = current_user.user_monster

    # 今日の目標距離
    @goal_distance = current_user.goal_distance || 0

    # 今日の歩行距離合計
    @today_walked_distance = current_user.destinations
      .where(walked_at: Time.zone.today.all_day)
      .sum("CAST(distance AS float)")
    # 進捗率（0〜100%）
    @daily_progress_percentage = if @goal_distance > 0
      [(@today_walked_distance / @goal_distance.to_f) * 100, 100].min
    else
      0
    end
  end
end
