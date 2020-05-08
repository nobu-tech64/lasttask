class TopPageController < ApplicationController
  def index
    @products = Product.all.order(id: "DESC").limit(5)
  end
end
