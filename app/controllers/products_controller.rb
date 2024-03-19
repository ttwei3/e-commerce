class ProductsController < ApplicationController
  def index
    base_query = if params[:category_id].present?
                   @category = Category.find(params[:category_id])
                   @category.products
                 else
                   Product.all
                 end

    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      base_query = base_query.where('product_name LIKE :keyword OR description LIKE :keyword', keyword: keyword)
    end

    @products = case params[:filter]
                when 'newly_added'
                  base_query.newly_added
                when 'recently_updated'
                  base_query.recently_updated
                else
                  base_query
                end

    @products = @products.page(params[:page]).per(6)
  end

  def show
    @product = Product.find(params[:id])
  end
end
