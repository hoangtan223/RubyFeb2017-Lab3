class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating, :user, :product, presence: true
  validates_inclusion_of :rating, in: 0..5
end
