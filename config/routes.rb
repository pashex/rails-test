RailsTest::Application.routes.draw do
  
  namespace 'api', defaults: { format: :json } do
    resources :books, except: [:new, :edit]
  end

end
