class Best < ApplicationRecord
  attachment :best_image
  belongs_to :user
  enum genre: { BEST_buy: 0, BEST_go: 1, BEST_use: 2 }
end
