RailsTest::Application.routes.draw do
  
  namespace 'api', defaults: { format: :json } do
    resources :books, except: [:new, :edit]
  end
  
  namespace :ng, path: '/' do
    root to: 'home#index', as: :home
    get '/*path', to: 'home#index'
  end 
  
end
