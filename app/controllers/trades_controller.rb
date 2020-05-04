class TradesController < ApplicationController
  def new
    
  end
  def create
    
  end
  def show
    
  end
  def pay
    Payjp.api_key = 'sk_test_94625a533c095949ce56a8f6'
    Payjp::Charge.create(
      amount: 3500, # 決済する値段
      card: params['payjp-token'],
      currency: 'jpy'
    )
  end
end
