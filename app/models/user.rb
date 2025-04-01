class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def own?(object)
    id == object&.user_id
  end
end
