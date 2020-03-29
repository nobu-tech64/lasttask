Rails.application.routes.draw do
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
end
