Rails.application.routes.draw do

  devise_for :users, path_names: { sign_in: 'access', sign_out: 'goodbye', sign_up: 'sign-me-up' }

  get 'home/index'
  get 'dashboard' => 'dashboard#index'

  resources :descriptions
  resources :beads,       controller: 'descriptions', type: 'bead',     path: "#{DescriptionsController::TYPE_ROUTE_PREFIX}/beads"
  resources :bead_sets,   controller: 'descriptions', type: 'bead-set', path: "#{DescriptionsController::TYPE_ROUTE_PREFIX}/bead-sets"
  resources :bracelets,   controller: 'descriptions', type: 'bracelet', path: "#{DescriptionsController::TYPE_ROUTE_PREFIX}/bracelets"
  resources :earrings,    controller: 'descriptions', type: 'earring',  path: "#{DescriptionsController::TYPE_ROUTE_PREFIX}/earrings"
  resources :necklaces,   controller: 'descriptions', type: 'necklace', path: "#{DescriptionsController::TYPE_ROUTE_PREFIX}/necklaces"
  resources :pendants,    controller: 'descriptions', type: 'pendant',  path: "#{DescriptionsController::TYPE_ROUTE_PREFIX}/pendants"
  resources :strands,     controller: 'descriptions', type: 'strand',   path: "#{DescriptionsController::TYPE_ROUTE_PREFIX}/strands"

  resources :materials
  resources :gemstones,   controller: 'materials', type: 'gemstone', path: "#{MaterialsController::TYPE_ROUTE_PREFIX}/gemstones"
  resources :metals,      controller: 'materials', type: 'metal',    path: "#{MaterialsController::TYPE_ROUTE_PREFIX}/metals"
  resources :man_mades,   controller: 'materials', type: 'man-made', path: "#{MaterialsController::TYPE_ROUTE_PREFIX}/man-mades"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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
