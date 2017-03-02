require 'rails_helper'

RSpec.describe Product, type: :model do
  subject {described_class.new }
  describe '.alphabetical' do
    it "return [] when there is not product" do
      expect(Product.alphabetical).to eq []
    end

    it "returns [a] when there is only one product a" do
      a = Product.create!(name: "test")
      expect(Product.alphabetical.count).to eq 1
      expect(Product.alphabetical.first).to eql(a)
    end

    it "returns [a,b,c] after I create 3 products c, b, a" do
      c = Product.create!(name: "c")
      b = Product.create!(name: "b")
      a = Product.create!(name: "a")

      expect(Product.alphabetical.count).to eq 3
      expect(Product.alphabetical).to eq [a, b, c]
    end
  end

  describe '#discount_amount' do

    it "Hats that cost > 100,000 VND are going to be 21% off" do
      p = Product.new price_vnd: 100_001
      expect(p.discount_amount).to within(0.1).of(0.21)
    end

    it "Hats that cost > 200,000 VND are going to be 31% off" do
      p = Product.new price_vnd: 200_001
      expect(p.discount_amount).to within(0.1).of(0.31)
    end

    it "Hats that cost > 800,000 VND are going to be 41% off" do
      p = Product.new price_vnd: 800_001
      expect(p.discount_amount).to within(0.1).of(0.41)
    end
  end

  describe '#final_price' do
    it "If the product cost 115,000 after discount, the final price should be 120,000" do
      p = Product.new
      allow(p).to receive(:sale_price) { 115_000 }
      expect(p.final_price).to eq 120_000
    end

    it "If the product cost 114,000 after discount, the final price should be 110,000" do
      p = Product.new
      allow(p).to receive(:sale_price) { 114_000 }
      expect(p.final_price).to eq 110_000
    end
  end

  describe '#on_sale?' do
    it "true if price > 100,000" do
      p = Product.new price_vnd: 100_001
      expect(p.on_sale?).to eq true
    end

    it "false if price <= 100,000" do
      p = Product.new price_vnd: 100_000
      expect(p.on_sale?).to eq false
    end
  end

  describe '#num_reviews' do
    it "should return 0 if product have no review" do
      p = Product.new
      expect(p.num_reviews).to eq 0
    end

    it "should return 2 if product have 2 reviews" do
      p = FactoryGirl.create(:product)
      FactoryGirl.create(:review, product: p, user: FactoryGirl.create(:user))
      FactoryGirl.create(:review, product: p, user: FactoryGirl.create(:user, email: "test@gm.com"))

      expect(p.num_reviews).to eq 2
    end
  end
end
