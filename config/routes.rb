Rails.application.routes.draw do
  # get 'show_calendar', to: 'drivers#show_calendar'

  get 'tasks' => 'tasks#calendar', as: :tasks
  get 'tasks/new' => 'tasks#new', as: :new_task
  post 'tasks' => 'tasks#create', as: :create_task
  get 'driver/:id/tasks/generate_csv' => 'tasks#generate_csv', as: :generate_csv

  resources :drivers do
    resources :tasks
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
