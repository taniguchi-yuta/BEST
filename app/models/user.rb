class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :bests, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_bests, through: :favorites, source: :best
  has_many :best_comments, dependent: :destroy
  validates :name, presence: true
end
