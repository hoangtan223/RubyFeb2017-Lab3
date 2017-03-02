require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ProductsHelper. For example:
#
# describe ProductsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ProductsHelper, type: :helper do
  # describe "#page_title" do
  #   it "returns true" do
  #     helper.page_title.should eq true
  #   end
  # end
  #
  describe "#product_discount_info" do
    it "should return string More than 40\% off! when price is > 800_000" do
      product = Product.new price_vnd: 800_001
      expect(helper.product_discount_info(product)).to include "More than 40\% off!"
    end

    it "should return string More than 30\% off! when price is > 200_000" do
      product = Product.new price_vnd: 200_001
      expect(helper.product_discount_info(product)).to include "More than 30\% off!"
    end

    it "should return string More than 20\% off! when price is > 100_000" do
      product = Product.new price_vnd: 100_001
      expect(helper.product_discount_info(product)).to include "More than 20\% off!"
    end

    it "If a hat is discounted by more than 100,000 VND, it should also include the text \"Save over X VND\"" do
      p = Product.new
      allow(p).to receive(:total_discount) { 100_001 }
      allow(p).to receive(:on_sale?) { false }
      expect(helper.product_discount_info(p)).to include("Save over #{p.total_discount} VND")
    end
  end
end
