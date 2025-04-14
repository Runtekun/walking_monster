class MonsterSpecies < ApplicationRecord
    has_many :user_monsters
    mount_uploader :image_1, MonsterImageUploader
    mount_uploader :image_2, MonsterImageUploader
    mount_uploader :image_3, MonsterImageUploader
  
    def name_for_level(level)
      if level >= evolution_level_2
        name_stage_3
      elsif level >= evolution_level_1
        name_stage_2
      else
        name_stage_1
      end
    end
  
    def image_for_level(level)
      if level >= evolution_level_2
        image_3
      elsif level >= evolution_level_1
        image_2
      else
        image_1
      end
    end
  end