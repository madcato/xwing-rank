XwingRank::Application.routes.draw do
  
  resources :rankings

  get 'faq' => 'public_tourney#faq'

  devise_for :users
  devise_for :admins

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :tourneys do
    get 'report' => 'tourneys#report'
    get 'dropPlayer/:player_id' => 'rounds#dropPlayer'
    get 'undropPlayer/:player_id' => 'rounds#undropPlayer'
    get 'removePlayer/:player_id' => 'rounds#removePlayer'
    get 'newPlayer/' => 'rounds#newPlayer'
    get 'printInscribed/' => 'tourneys#printInscribed'
    get 'printRanking/' => 'tourneys#printRanking'
    post 'createInscription/' => 'rounds#createInscription'
    post 'createAndSeedRound/' => 'rounds#createAndSeedRound'
    get 'createAndSeedRound/' => 'rounds#createAndSeedRound'
    get 'elimination/' => 'tourneys#elimination'
    post 'startElimination/' => 'tourneys#startElimination'
    resources :rounds do
      get 'seedRound/' => 'rounds#seedRound'
      get 'printRound/' => 'rounds#printRound'
      resources :matches
    end
  end

  resources :players


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'players#list'

  get 'simple' => 'players#simple'

  get 'tourney/:publicId' => 'public_tourney#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
