class UserMonster < ApplicationRecord
    belongs_to :user
    belongs_to :monster_species

  # 多項式的に次のレベルに必要な経験値を計算
  def experience_to_next_level
    base_experience = 50    # レベル1から2に必要な基本経験値
    growth_factor = 1.15    # 経験値成長係数
    exponent = 1.3          # 多項式の指数

   # 経験値の増加を多項式で計算
    (base_experience * (growth_factor * level) ** exponent).to_i
  end
  
    validates :level, numericality: { only_integer: true, greater_than: 0 } # level>0　(整数のみ)
    validates :experience, numericality: { only_integer: true, greater_than_or_equal_to: 0 } #0以上の整数のみ
end
