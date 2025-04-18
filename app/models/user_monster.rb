class UserMonster < ApplicationRecord
  belongs_to :user
  belongs_to :monster_species

  # モンスターの経験値計算に使用する定数
  BASE_EXP = 50          # レベル1の基準経験値
  GROWTH_FACTOR = 1.15   # 経験値の成長率
  EXPONENT = 1.3         # 経験値計算の指数

  # 指定されたレベルに到達するために必要な経験値を計算
  # lv: 計算するレベル
  def experience_for_level(lv)
    # 経験値計算式: 基本経験値 * (成長率 * レベル) ^ 指数
    (BASE_EXP * (GROWTH_FACTOR * lv) ** EXPONENT).to_i
  end

  # 指定されたレベルに達するための累積経験値を計算
  # lv: 累積経験値を計算するレベル
  def total_experience_for_level(lv)
    # レベル1には累積経験値は必要ないので0を返す
    return 0 if lv <= 1
    # 1レベルから指定レベル-1までの経験値を合計
    (1...lv).sum { |l| experience_for_level(l) }
  end

  # 現在の経験値に基づいて、モンスターのレベルを再計算する
  # 経験値が増加した際に呼び出し、レベルを更新する
  def recalculate_level!
    new_level = level
    # 次のレベルに達するために必要な累積経験値を持っている場合、レベルを上げる
    while experience >= total_experience_for_level(new_level + 1)
      new_level += 1
    end

    # 計算された新しいレベルが現在のレベルと異なる場合に更新
    self.level = new_level if new_level != level
  end

  # 現在のレベルから次のレベルに必要な経験値との差を返す
  # 経験値が足りている場合は0を返す
  def experience_remaining_to_next_level
    # 次のレベルに必要な累積経験値
    next_level_total = total_experience_for_level(level + 1)
    # 現在の経験値との差を計算し、0未満にはならないようにする
    [next_level_total - experience, 0].max
  end

  # 現在のレベルに到達するために必要な最小経験値を返す
  # プログレスバーなどに使える
  def experience_current_level_base
    total_experience_for_level(level)
  end

  # バリデーション: レベルは1以上の整数
  validates :level, numericality: { only_integer: true, greater_than: 0 }
  # バリデーション: 経験値は0以上の整数
  validates :experience, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end