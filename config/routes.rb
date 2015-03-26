Rails.application.routes.draw do

  root 'exercises#index'

  resources :users

  resources :exercise_hypotheses

  resources :hypotheses

  resources :tasks

  resources :exercises

  resources :sessions, only: [:new, :create, :destroy]

  resources :hypothesis_groups, only: [:new, :create, :destroy]

  resources :checked_hypotheses, only: [:new, :create, :destroy]

  resources :completed_tasks, only: [:create]

  resources :subtasks

  resources :task_texts

  resources :multichoices

  resources :options

  resources :interviews

  resources :questions

  resources :question_groups

  resources :asked_questions, only: [:create]

  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  post 'tasks/:id/up', to: 'tasks#level_up'
  post 'tasks/:id/down', to: 'tasks#level_down'

  post 'multichoices/:id/check_answers', to: 'multichoices#check_answers'
  post 'interviews/:id/ask_question', to: 'interviews#ask_question'
  post 'interviews/:id/check_answers', to: 'interviews#check_answers'
  post 'task_texts/:id/check_answers', to: 'task_texts#check_answers'

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
