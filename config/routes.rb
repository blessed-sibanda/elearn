Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  get "/s/:subject", to: "home#index", as: :subject_courses
  authenticate :user do
    scope controller: :dashboard, path: "/dashboard" do
      get "/" => :index, as: :dashboard_index
      get "courses" => :courses, as: :dashboard_courses
      get "students" => :students, as: :dashboard_students
      get "notifications" => :notifications, as: :dashboard_notifications
      get "messages" => :messages, as: :dashboard_messages
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
