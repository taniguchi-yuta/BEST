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
  validates :name, presence: true, length: { maximum: 10 }
  validates :introduction, length: { maximum: 200 }

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
