class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @products = Product.all.limit(3)
  end

  def new
    
    @product = Product.new
    @product.build_brand
    @product.images.new
    @category_parent_array = Category.where(ancestry: nil)
  end

  def create
    @product = Product.new(post_params)
    # @images = @products.images.build
    if @product.save
      redirect_to root_path
    else
      @product.images.build
      # renderでユーザーが入力した内容を残しつつ画面を商品出品ページに遷移するが、@category_parent_arrayは渡せてないので改めて渡し直す必要がある
      @category_parent_array = Category.where(ancestry: nil)
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

  def show
    @products = Product.find(params[:id])
  end

  private
  def post_params
    params.require(:product).permit(:name, :description, :category_id, :condition_id, :burden_id, :from_area_id, :delivery_days_id, :price, brand_attributes: [:id, :name], images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def set_product
    @products = Product.find(1)
  #  (params[:id])
  end

end
