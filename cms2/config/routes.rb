Cms2::Application.routes.draw do  
  
  root to: "public#index"
  get 'admin', :to => 'access#menu'
  get 'show/:id', :to => 'sections#show'
  get ':controller(/:action(/:id(.:format)))'  
	
	post "admin_users/update"
  	post "subjects/update"
	post "pages/update"
	post "sections/update"
	
	post "subjects/destroy"
	post "subjects/create"
	
	post "pages/destroy"
	post "pages/create"
	
	post "sections/destroy"
	post "sections/create"
	
	post "admin_users/destroy"
	post "admin_users/create"
	
	post "access/attempt_login"
	
	get "access/logout"

end
