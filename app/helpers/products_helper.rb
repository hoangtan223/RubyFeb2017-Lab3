module ProductsHelper
  def product_discount_info(product)
    result = ''
    if product.on_sale?
     result += "More than #{ (product.discount_amount * 100 -1).to_i }% off! "
    end

    if product.total_discount > 100_000
      result += "Save over #{product.total_discount} VND"
    end
    return result
  end
end
