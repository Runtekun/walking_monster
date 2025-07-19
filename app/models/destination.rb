class Destination < ApplicationRecord
    geocoded_by :address # addressカラムを基準に緯度経度を算出する。
    after_validation :geocode # 住所変更時に緯度経度も変更する。
    belongs_to :user

    validates :start, presence: true
    validates :end, presence: true
    validates :distance, presence: true
    validates :duration, presence: true
    validate :walkable_distance

     private

    def walkable_distance
    #distanceは「5.6 km」などの文字列なので数値部分だけ取り出す
    dist_value = distance.to_s.match(/[\d\.]+/).to_s.to_f
    max_distance_km = 15.0

    if dist_value > max_distance_km
      errors.add(:distance, "は最大#{max_distance_km}kmまでにしてください。")
    end
  end
end
