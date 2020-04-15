class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
  end

  def create
    Product.create(post_params)
  end

  private
  def post_params
    params.require(:product).permit(:name, :description, :condition, :size, :burden_id, :from_area, :delivery_days, :price)
  end
end
