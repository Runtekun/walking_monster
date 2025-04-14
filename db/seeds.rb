# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
MonsterSpecies.create!([
  {
    description: "炎の力を持ったモンスター。レベルが上がるにつれ、炎の翼を持つ伝説のドラゴンへと進化する。",
    name_stage_1: "ヒノコ",
    name_stage_2: "カエン",
    name_stage_3: "フレイムドラゴン",
    image_1: File.open(Rails.root.join("app/assets/images/flame_dragon_stage1.png")),
    image_2: File.open(Rails.root.join("app/assets/images/flame_dragon_stage2.png")),
    image_3: File.open(Rails.root.join("app/assets/images/flame_dragon_stage3.png")),
    evolution_level_1: 5,
    evolution_level_2: 10
  },
  {
    description: "水の精霊のような存在。清らかな水の力を使って成長していく。",
    name_stage_1: "ミズチ",
    name_stage_2: "アクア",
    name_stage_3: "ウォータースピリット",
    image_1: File.open(Rails.root.join("app/assets/images/water_spirit_stage1.png")),
    image_2: File.open(Rails.root.join("app/assets/images/water_spirit_stage2.png")),
    image_3: File.open(Rails.root.join("app/assets/images/water_spirit_stage3.png")),
    evolution_level_1: 4,
    evolution_level_2: 9
  },
  {
    description: "森の守護者。植物と一体化したような姿を持ち、成長すると巨大な樹の獣になる。",
    name_stage_1: "モリゾー",
    name_stage_2: "ジャングラ",
    name_stage_3: "リーフビースト",
    image_1: File.open(Rails.root.join("app/assets/images/leaf_beast_stage1.png")),
    image_2: File.open(Rails.root.join("app/assets/images/leaf_beast_stage1.png")),
    image_3: File.open(Rails.root.join("app/assets/images/leaf_beast_stage1.png")),
    evolution_level_1: 6,
    evolution_level_2: 12
  }
])

