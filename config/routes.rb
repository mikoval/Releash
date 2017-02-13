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

  get 'animals/query'
  get 'animals/search'
  get '/animals/new'
  get '/animals/profile'
  get '/animals/edit'
  get '/animals', to: 'animals#list'
  post  '/animals',   to: 'animals#newAnimal'
  patch  '/animals',   to: 'animals#editAnimal'

  get 'alerts/new'
  get 'alerts/list'
  post  '/alerts',   to: 'alerts#newAlert'

  get '/people', to: "people#list"
  get 'people/new'
  get 'people/edit'
  get 'people/query'
  get 'people/profile'
  post '/people', to: 'people#addEmployee'
  patch '/people', to: 'people#editEmployee'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'


  
  resources :users
  
  root 'main#home'
end
