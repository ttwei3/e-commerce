class ProductsController < ApplicationController
  class ProductsController < ApplicationController
    def index
      @products = Product.all
    end

    def show
      @product = Product.find(params[:id])
    end
  end

end
