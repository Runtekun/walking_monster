class Destination < ApplicationRecord
    geocoded_by :address # addressカラムを基準に緯度経度を算出する。
    after_validation :geocode # 住所変更時に緯度経度も変更する。
    belongs_to :user
end
