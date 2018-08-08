Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  resources :users do
    resources :tasks
  end
  namespace :admin do
    # authenticate :admin do
    resources :users do
      resources :projects
      resources :tasks do
        collection do
          get :list_project_developers
          get :developer_task_list
          get :project_task_list
          get :pie_data
        end
      end
    end
    # end
  end


  # authenticated :user do
  #   root to: 'projects#index', as: :authenticated_root
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
