Rails.application.routes.draw do
  devise_for :users
  root "top_page#index"
  get "/mypage" => "top_page#mypage"
  get "/login" => "top_page#login"
  get "/signup" => "top_page#signup"
  get "/item" => "top_page#item"
  get "/exhibition" => "top_page#exhibition"
  get "/buy_page" => "top_page#buy_page"
  get "/adress" => "top_page#adress"
  get "/card" => "top_page#card"
  get "/logout" => "top_page#logout"
  get "/payment" => "top_page#payment"
  get "/mypage_card" => "top_page#mypage_card"
  get "/card_edit" => "top_page#card_edit"
  get "/adress_edit" => "top_page#adress_edit"
end
