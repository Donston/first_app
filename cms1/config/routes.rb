Cms1::Application.routes.draw do
  
  get "admin_users/list"
  get "admin_users/new"
  get "admin_users/edit"
  get "admin_users/delete"
 	get ':controller(/:action(/:id(.:format)))'
  	get 'admin', :to => 'access#menu'
  	get 'access/login'
	
  	post "subjects/update"
	post "pages/update"
	post "sections/update"
	
	post "subjects/destroy"
	post "subjects/create"
	
	post "pages/destroy"
	post "pages/create"
	
	post "sections/destroy"
	post "sections/create"
	
	post "access/attempt_login"
	
	
	
	root to: "subjects#list"


end
