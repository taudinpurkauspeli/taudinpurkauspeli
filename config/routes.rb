Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
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

  resources :conclusions

  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  post 'tasks/:id/up', to: 'tasks#level_up'
  post 'tasks/:id/down', to: 'tasks#level_down'

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
