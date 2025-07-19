class Destination < ApplicationRecord
    geocoded_by :address # addressカラムを基準に緯度経度を算出する。
    after_validation :geocode # 住所変更時に緯度経度も変更する。
    belongs_to :user

    validates :start, presence: true
    validates :end, presence: true
    validates :distance, presence: true
    validates :duration, presence: true
end
