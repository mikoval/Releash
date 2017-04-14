Rails.application.routes.draw do

# the first part is what they are going to 
# for example localhost:3000/home, localhost:3000/people/new, localhost:3000/animal
# if it says 'to:' that means forward that request to x#y with x being the controller and y being the action (which is kinda like a view)
# but doesn't have to have a view, can just be a function that does something then redirects after 
# a page can accept a post and get request at any url. this is what determines how those requests are handled. 
#
# This is important for creating a RESTful API. 
# If you dont know what that means, then look up what makes an api RESTful. Basically it means that pages accept post/get requests at the same url 
# handles it from there. 
# for example post to animal should add an animal, get at animal should list animals or get a specific one, depending on how you want to do it. 
 


  get '/home', to: 'main#home'
  patch '/dashboard', to: 'people#dashboardSave'
  get '/dashboard', to: 'people#dashboardGet'

  get 'animals/query'
  get 'animals/querySimple'
  get 'animals/querySimpleStatus'
  get 'animals/querySimpleCoor'
  get 'animals/search'
  get '/animals/new'
  get '/animals/profile'
  get '/animals/edit'

  get '/animals', to: 'animals#list'
  post  '/animals',   to: 'animals#newAnimal'
  patch  '/animals',   to: 'animals#editAnimal'
  delete  '/animals',   to: 'animals#destroy'

  get 'intake/new'   
  get 'intake/edit'
  get 'intake/list'
  post 'intake/new', to:'intake#newIntake'
  patch 'intake/edit', to: 'intake#editIntake'
  
  get 'vetting/new'
  get 'vetting/edit'
  get 'vetting/list'
  post 'vetting/new', to:'vetting#newVetting'
  patch 'vetting/edit', to: 'vetting#editVetting'

  get 'foster/new'
  get 'foster/edit'
  get 'foster/list'
  post 'foster/new', to:'foster#newFoster'
  patch 'foster/edit', to: 'foster#editFoster'

  get 'training/new'
  get 'training/edit'
  get 'training/list'
  post 'training/new', to:'training#newTraining'
  patch 'training/edit', to: 'training#editTraining'

  get 'other/new'
  get 'other/edit'
  get 'other/list'
  post 'other/new', to: 'other#newOther'
  patch 'other/edit', to: 'other#editOther'

  get 'animal_application/new'
  get 'animal_application/edit'
  post 'animal_application/new', to: 'animal_application#newApp'
  patch 'animal_application/edit', to: 'animal_application#editApp'

  get 'adopted/new'
  get 'adopted/edit'
  get 'adopted/list'
  post 'adopted/new', to: 'adopted#newAdopted'
  patch 'adopted/edit', to: 'adopted#editAdopted'

  get 'alerts/new'
  get 'alerts/edit'
  get 'alerts/list'
  get 'alerts/completed'
  get 'alerts/query'
  get '/alerts', to: "alerts#list"
  post  '/alerts',   to: 'alerts#newAlert'
  patch  '/alerts',   to: 'alerts#editAlert'
  delete  '/alerts',   to: 'alerts#deleteAlert'
  post  '/alerts/unsubscribeAlert'

  get '/people', to: "people#list"
  get 'people/new'
  get 'people/edit'
  get 'people/query'
  get 'people/profile'


  post '/people', to: 'people#addEmployee'
  patch '/people', to: 'people#editEmployee'

  get 'password_resets/new'

  get 'password_resets/edit'



  get 'non_user/profile'
  get 'non_user/edit'
  get 'non_user/new'
  get 'non_user/list'
  post '/non_user', to: 'non_user#newUser'
  patch '/non_user', to: 'non_user#editUser'

  get 'trainer/new'
  get 'trainer/profile'
  get 'trainer/list'
  get 'trainer/edit'
  post '/trainer', to: 'trainer#newTrainer'
  patch '/trainer', to: 'trainer#editTrainer'

  get 'veterinarian/new'
  get 'veterinarian/list'
  get 'veterinarian/edit'
  get 'veterinarian/profile'
  post '/veterinarian', to: 'veterinarian#newVet'
  patch '/veterinarian', to: 'veterinarian#editVet'

  get 'animal_facility/new'
  get 'animal_facility/edit'
  get 'animal_facility/profile'
  post '/animal_facility', to: 'animal_facility#newAnifaci'
  patch '/animal_facility', to: 'animal_facility#editAnifaci'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'


  
  resources :users
  resources :account_activations, only: [:edit]
  resources :alert_completions, only: [:edit]

  resources :password_resets,     only: [:new, :create, :edit, :update]
  
  root 'main#home'
end
