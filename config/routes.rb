Rails.application.routes.draw do

  resources :log_entries
  root 'diagnose_diseases#index'

  resources :users

  resources :exercise_hypotheses

  resources :hypotheses

  resources :tasks

  resources :exercises

  resources :sessions, only: [:new, :create, :destroy]

  resources :hypothesis_groups

  resources :checked_hypotheses, only: [:new, :create, :destroy, :index]

  resources :completed_tasks, only: [:create]

  resources :subtasks

  resources :task_texts

  resources :multichoices

  resources :options

  resources :interviews

  resources :questions

  resources :question_groups

  resources :conclusions

  resources :banks

  resources :titles

  get 'taudinpurkauspeli', to: 'diagnose_diseases#index'
  get 'hypothesis_bank', to: 'hypotheses#hypothesis_bank'
  get 'hypotheses_all', to: 'hypotheses#hypotheses_all'
  get 'hypothesis_groups_and_hypotheses', to: 'hypothesis_groups#hypothesis_groups_and_hypotheses'
  get 'correct_diagnosis', to: 'hypotheses#correct_diagnosis'
  get 'unchecked_hypotheses', to: 'exercise_hypotheses#unchecked_hypotheses'

  get 'exercises_one/:id', to: 'exercises#exercises_one'
  put 'exercises_one/:id', to: 'exercises#update_one'

  get 'users_json', to: 'users#json_index'
  delete 'delete_user_json/:id', to: 'users#json_destroy'
  get 'users_by_case_json', to: 'users#json_by_case'
  get 'users/:id/completable_subtasks', to: 'users#completable_subtasks'
  get 'users/:id/completed_tasks', to: 'users#completed_tasks'
  get 'users/:id/has_completed_task', to: 'users#has_completed_task'
  get 'users/:id/has_completed_conclusion', to: 'users#has_completed_conclusion'
  get 'users/:id/has_completed_exercise', to: 'users#has_completed_exercise'

  get 'tasks_one/:id', to: 'tasks#tasks_one'
  get 'tasks_all_by_level', to: 'tasks#tasks_all_by_level'
  get 'tasks_all', to: 'tasks#tasks_all'
  get 'tasks_student_index', to: 'tasks#student_index'
  get 'task_can_be_started/:id', to: 'tasks#task_can_be_started'
  post 'json_tasks_create', to: 'tasks#json_create'

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

  # Subtask up and down levels
  post 'subtasks/:id/move_up', to: 'subtasks#move_up'
  post 'subtasks/:id/move_down', to: 'subtasks#move_down'

  post 'multichoices/:id/check_answers', to: 'multichoices#check_answers'
  post 'interviews/:id/ask_question', to: 'interviews#ask_question'
  post 'interviews/:id/check_answers', to: 'interviews#check_answers'
  post 'task_texts/:id/check_answers', to: 'task_texts#check_answers'
  post 'conclusions/:id/check_answers', to: 'conclusions#check_answers'

  post 'exercises/:id/dup', to: 'exercises#duplicate_exercise'
  post 'exercises/:id/hide', to: 'exercises#toggle_hidden'

  post 'questions/:id/ask', to: 'questions#ask'

  post 'task_texts_json_create', to: 'task_texts#json_create'
  post 'multichoices_json_create', to: 'multichoices#json_create'
  post 'options_json_create', to: 'options#json_create'
  post 'interviews_json_create', to: 'interviews#json_create'
  post 'questions_json_create', to: 'questions#json_create'
  post 'conclusions_json_create', to: 'conclusions#json_create'
  put 'conclusions_json/:id', to: 'conclusions#json_update'
  delete 'conclusions_json/:id', to: 'conclusions#json_destroy'

  get 'exercise_hypotheses_only', to: 'exercise_hypotheses#only_exercise_hypotheses'
  get 'exercise_hypotheses_json_index', to: 'exercise_hypotheses#json_index'

  get 'options_multichoice', to: 'options#multichoice_index'
  get 'questions_interview', to: 'questions#interview_index'
  get 'exercise_hypotheses_conclusion', to: 'exercise_hypotheses#exercise_hypotheses_conclusion'

  get 'banks_and_titles', to: 'banks#banks_and_titles'
  get 'banks/:id/titles', to: 'banks#bank_titles'
  get 'questions_admin', to: 'questions#index_admin'
  get 'questions_only', to: 'questions#only_questions'
  get 'options_only', to: 'options#only_options'

  get 'task_names', to: 'tasks#task_names'


end
