Dream::Application.routes.draw do
  
  get "posts/list"
  get "comments/list"
  get "comments/show"
  get "users/_form"
  get "users/index"
  get "users/edit"
  get "users/list"
  get "users/new"
  get "users/show"
  get "categories/list"
  get "categories/edit"
  get "category/list"
  get "category/edit"
  root to: "public#index"
  #get 'admin', :to => 'access#menu'
  #get 'show/:id', :to => 'sections#show'
  get ':controller(/:action(/:id(.:format)))' 
  
  post "posts/add_comment"
  post "posts/create"
  post "posts/update"
  post "categories/create"
  post "categories/update"
  post "users/manage"
  post "comments/set_status"
  post "staff/send_login"
  post "main/add_comment"
end
