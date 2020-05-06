class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

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

  def edit
    @category = Category.order("id ASC").limit(13)
    @product = Product.find(params[:id]).presence || "商品は存在しません"

    # 親セレクトボックスの初期値(配列)
    @category_parent_array = []
    # categoriesテーブルから親カテゴリーのみを抽出、配列に格納
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
    # itemに紐づいていいる孫カテゴリーの親である子カテゴリが属している子カテゴリーの一覧を配列で取得
    @category_child_array = @product.category.parent.parent.children
    # itemに紐づいていいる孫カテゴリーが属している孫カテゴリーの一覧を配列で取得
    @category_grandchild_array = @product.category.parent.children
  end

  def update
    @product = Product.find(params[:id])
      if @product.update(product_update_params)
        redirect_to product_path(@product.id)
      else
        redirect_to root_path
      end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    if @product.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private
  def post_params
    params.require(:product).permit(:name, :description, :category_id, :condition_id, :burden_id, :from_area_id, :delivery_days_id, :price, brand_attributes: [:id, :name], images_attributes: [:image]).merge(seller_id: current_user.id)
  end

  def set_product
    @products = Product.find(params[:id])
  #  (params[:id])
  end

  def product_update_params
    params.require(:product).permit(:name, :description, :category_id, :condition_id, :burden_id, :from_area_id, :delivery_days_id, :price, brand_attributes: [:id, :name], images_attributes: [:image]).merge(seller_id: current_user.id)
  end

end
