class VisitorsController < ApplicationController
  def index
    if (params[:sort] == 'alphabetical')
      @products = Product.alphabetical
    elsif (params[:sort] == 'total_discount')
      @products = Product.all.sort_by {|product| product.total_discount}.reverse!
    else
      @products = Product.all
    end
  end
end
