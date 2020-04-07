class Best < ApplicationRecord
  attachment :best_image
  belongs_to :user
end
