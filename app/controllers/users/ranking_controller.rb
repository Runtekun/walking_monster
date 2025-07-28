class Users::RankingController < ApplicationController
  def index
    # 期間・カテゴリをパラメータで受け取る（例：steps, monster_level / all_time, weekly, monthly）
    @ranking_category = params[:category] || 'steps'
    @ranking_period = params[:period] || 'all_time'

    # UserRankingテーブルから対象のランキングを取得（上位20件などに絞る）
    @rankings = UserRanking.where(
      ranking_category: @ranking_category,
      ranking_period: @ranking_period
    ).order(:rank).limit(20).includes(:user)
  end
end