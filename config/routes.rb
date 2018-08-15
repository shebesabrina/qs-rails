Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :meals, except: [:new, :edit] do
        resources :foods, except: [:new, :edit]
        # get '/meals/:id/foods', to: 'meals#show'
        # post 'meals/:meal_id/foods/:id', to: 'meals#create'
        # delete 'meals/:meal_id/foods/:id', to: 'meals#destroy'
      end
    end
  end
end
