class Product < ActiveRecord::Base
  before_save :set_default_image_path
  validates :name, presence: true

  has_many :reviews

  def self.alphabetical
    return self.order(:name)
  end

  def discount_amount
    return 0.41 if self.price_vnd > 800_000
    return 0.31 if self.price_vnd > 200_000
    return 0.21 if self.price_vnd > 100_000
  end

  def sale_price
    (self.price_vnd * ( 1 - discount_amount ))
  end

  def final_price
    self.sale_price.round(-4)
  end

  def on_sale?
    price_vnd > 100_000
  end

  def total_discount
    self.price_vnd - self.final_price
  end

  def num_reviews
    self.reviews.count
  end

  private

  def set_default_image_path
    self.image_path ||= "http://lorempixel.com/200/200/fashion"
  end
end
