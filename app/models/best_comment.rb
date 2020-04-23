class BestComment < ApplicationRecord
  belongs_to :user
  belongs_to :best
  validates :comment, presence: true
end