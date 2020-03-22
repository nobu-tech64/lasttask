Rails.application.routes.draw do
  root "top_page#index"
  get "/mypage" => "top_page#mypage"
  get "/login" => "top_page#login"
  get "/signup" => "top_page#signup"
  get "/item" => "top_page#item"
  get "/exhibition" => "top_page#exhibition"
  get "/buy_page" => "top_page#buy_page"
end
