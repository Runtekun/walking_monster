class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]

  validates :name, presence: true, length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validates :uid, uniqueness: { scope: :provider }, allow_nil: true
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :destinations, dependent: :destroy
  has_one :user_monster, dependent: :destroy
  has_many :user_rankings, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  def own?(object)
    id == object&.user_id
  end

  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.remote_avatar_url = auth.info.image
    end
  end

  def total_adventure_count
    destinations.where.not(walked_at: nil).count
  end
end
