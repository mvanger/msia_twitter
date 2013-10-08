MsiaTwitter::Application.routes.draw do
  root to: 'tweets#index'
  get '/tweets' => 'tweets#tweets'
end
