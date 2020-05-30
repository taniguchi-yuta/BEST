class Best < ApplicationRecord
  attachment :best_image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :best_comments, dependent: :destroy
  enum genre: { BEST_buy: 0, BEST_go: 1, BEST_use: 2 }
  validates :best_name, presence: true, length: { maximum: 15 }
  validates :recommend, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
