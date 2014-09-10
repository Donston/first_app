Blog::Application.routes.draw do
  
  get "comments/list"
  get "comments/show"
  #resources :blog_posts
  
  root to: "public#index"
  #get 'admin', :to => 'access#menu'
  #get 'show/:id', :to => 'sections#show'
  get ':controller(/:action(/:id(.:format)))' 
  
  post "comments/set_status"
  post "blog_posts/update"
  post "blog_posts/create"
  post "blog_posts/destroy"
  
  post "categories/update"
  post "categories/create"
  post "categories/destroy"
  post "categories/list"
  
  post "users/manage"
  post "staff/send_login"
  
  post "main/add_comment"
  
  
end
