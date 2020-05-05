class PurchaseController < ApplicationController
  # before_action :product_params

  require 'payjp'


  def pay
    @products = Product.find(params[:product_id])
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = "sk_test_1e0139507a3138d861f93ed5"
    Payjp::Charge.create(
    :amount => @products.price, #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
  )
  redirect_to action: 'done' #完了画面に移動
  end

  def show
    @products = Product.find(params[:product_id])
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = "sk_test_1e0139507a3138d861f93ed5"
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end




  private
  # def set_product
  #   @products = Product.find(params[:id])
  # #  (params[:id])
  # end

  def product_params
    params.permit(
      :name,
      :description,
      :price,
    )
  end

end