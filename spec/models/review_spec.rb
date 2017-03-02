require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "model validation" do
    it "should require rating field" do
      review = Review.new
      review.valid?
      expect(review.errors).to have_key(:rating)
    end

    it "should require user" do
      review = Review.new
      review.valid?
      expect(review.errors).to have_key(:user)
    end

    it "should require product" do
      review = Review.new
      review.valid?
      expect(review.errors).to have_key(:product)
    end

    it "rating must be an integer between 0 and 5" do
      review1 = Review.new rating: -1
      review2 = Review.new rating: 3, user: FactoryGirl.create(:user), product: FactoryGirl.create(:product)
      review3 = Review.new rating: 6

      review1.valid?
      review3.valid?
      expect(review1.errors).to have_key(:rating)
      expect(review3.errors).to have_key(:rating)
      expect(review2.valid?).to eq true
    end
  end
end
