Rails.application.routes.draw do
  # This single line creates all the standard routes (index, show, create, update, destroy)
  # for all three of your resources without nesting them.
  resources :categories
  resources :equipment
  resources :maintenance_records
end
