class DashboardController < ApplicationController
  def show
    # ユーザーのモンスター情報
    @user_monster = current_user.user_monster

    # ==== 歩数関連 ====

    today_range = Date.current.all_day

    # 今日の合計歩数
    @today_steps = current_user.destinations.where(walked_at: today_range).sum(:steps) || 0

    # 目標歩数（ユーザーが設定していない場合は0）
    @goal_steps = current_user.goal_steps || 0

    # 進捗率（％）
    @step_progress =
      if @goal_steps.positive?
        ((@today_steps.to_f / @goal_steps) * 100).round
      else
        0
      end

    # ==== モンスター育成関連 ====

    if @user_monster
      @monster_name = @user_monster.monster_species.name_for_level(@user_monster.level)
      @monster_level = @user_monster.level

      current_exp_base = @user_monster.experience_current_level_base
      next_level_exp   = @user_monster.next_level_experience
      current_exp      = @user_monster.experience

      @experience_percentage =
        if next_level_exp > current_exp_base
          (((current_exp - current_exp_base).to_f / (next_level_exp - current_exp_base)) * 100).round
        else
          0
        end

      @remaining_xp_to_level_up = @user_monster.experience_remaining_to_next_level
    end

    # ==== ランキング関連 ====

    @walking_ranking = UserRanking
                         .includes(user: { user_monster: :monster_species }) # N+1対策
                         .where(ranking_category: :steps, ranking_period: :weekly)
                         .order(score: :desc)
                         .limit(3)
  end
end
