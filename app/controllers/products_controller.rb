class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
    @product.build_brand
    @product.images.new
    @category_parent_array = Category.where(ancestry: nil)
  end

  def create
    @product = Product.new(post_params)
    if @product.save
      redirect_to new_product_path(@product)
    end
  end

  # 親カテゴリーが選択されたときに動くアクション
  def get_category_children
    # 選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find("#{params[:parent_name]}").children
  end

  # 子カテゴリーが選択されたときに動くアクション
  def get_category_grandchildren
    # 選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private
  def post_params
    params.require(:product).permit(:name, :description, :category_id, :condition_id, :burden_id, :from_area_id, :delivery_days_id, :price, brand_attributes: [:id, :name], images_attributes: [:image])
  end
end
