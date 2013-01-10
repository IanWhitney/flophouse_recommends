FlophouseRecommends::Application.routes.draw do
  root to: "episodes#index"

  resources :episodes, :only => [:index, :show] do
    collection do
      post :find
    end
  end

  resources :hosts, :only => [:show]

  resources :movies, :only => [:show]
end
