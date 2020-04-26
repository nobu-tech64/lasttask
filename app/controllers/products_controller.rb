class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
    @product.build_brand
    @product.images.new
    @category_parent_array = ["選択してください"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end  
  end

  def create
    @product = Product.new(post_params)
    @product.save
    redirect_to new_product_path(@product)
  end

  # 親カテゴリーが選択されたときに動くアクション
  def get_category_children
    # 選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  # 子カテゴリーが選択されたときに動くアクション
  def get_category_grandchildren
    # 選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private
  def post_params
    params.require(:product).permit(:name, :description, :condition_id, :burden_id, :from_area_id, :delivery_days_id, :price, brand_attributes: [:id, :name], images_attributes: [:image])
  end
end
