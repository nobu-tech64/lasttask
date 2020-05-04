class TopPageController < ApplicationController
  def index
    @products = Product.all.limit(5)
  end
end
