class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
    @product.build_brand
    @product.images.new
  end

  def create
    @product = Product.new(post_params)
    @product.save
    redirect_to new_product_path(@product)
  end

  private
  def post_params
    params.require(:product).permit(:name, :description, :condition_id, :burden_id, :from_area_id, :delivery_days_id, :price, brand_attributes: [:id, :name], image_attributes: [:image])
  end
end
