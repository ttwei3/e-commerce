class ProductsController < ApplicationController
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @products = @category.products.page(params[:page]).per(6)
    else
      @products = Product.page(params[:page]).per(6)
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
