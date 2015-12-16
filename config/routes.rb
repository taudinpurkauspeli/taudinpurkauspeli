Rails.application.routes.draw do

  resources :log_entries
  mount Ckeditor::Engine => '/ckeditor'
  root 'exercises#index'

  resources :users

  resources :exercise_hypotheses

  resources :hypotheses

  resources :tasks

  resources :exercises

  resources :sessions, only: [:new, :create, :destroy]

  resources :hypothesis_groups, only: [:new, :create, :destroy, :index, :show, :update]

  resources :checked_hypotheses, only: [:new, :create, :destroy]

  resources :completed_tasks, only: [:create]

  resources :subtasks

  resources :task_texts

  resources :multichoices

  resources :options

  resources :interviews

  resources :questions

  resources :question_groups

  resources :conclusions

  get 'taudinpurkauspeli', to: 'diagnose_diseases#index'
  get 'hypothesis_bank', to: 'hypotheses#hypothesis_bank'
  get 'hypotheses_all', to: 'hypotheses#hypotheses_all'
  get 'exercises_one/:id', to: 'exercises#exercises_one'
  get 'tasks_one/:id', to: 'tasks#tasks_one'
  get 'tasks_all', to: 'tasks#tasks_all'

  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  # Old level_up and level_down routes
  post 'tasks/:id/up', to: 'tasks#level_up'
  post 'tasks/:id/down', to: 'tasks#level_down'

  # New level up and down routes for directly from level to level movement
  post 'tasks/:id/move_up', to: 'tasks#move_level_up'
  post 'tasks/:id/move_down', to: 'tasks#move_level_down'

  # New level up and down routes for movement from level to between levels
  post 'tasks/:id/move_task_up', to: 'tasks#move_task_up'
  post 'tasks/:id/move_task_down', to: 'tasks#move_task_down'

  # Not sure what these are for
  get 'tasks/:id/up', to: 'tasks#level_up'
  get 'tasks/:id/down', to: 'tasks#level_down'

  post 'multichoices/:id/check_answers', to: 'multichoices#check_answers'
  post 'interviews/:id/ask_question', to: 'interviews#ask_question'
  post 'interviews/:id/check_answers', to: 'interviews#check_answers'
  post 'task_texts/:id/check_answers', to: 'task_texts#check_answers'
  post 'conclusions/:id/check_answers', to: 'conclusions#check_answers'

  post 'exercises/:id/dup', to: 'exercises#duplicate_exercise'
  post 'exercises/:id/hide', to: 'exercises#toggle_hidden'
end
