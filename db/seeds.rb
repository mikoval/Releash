#  this is where you put in values that you want in the database when created. 
# run 'rake db:seed'
Role.create([{title: 'Volunteer'}, {title: 'Employee'}, {title: 'Administrator '}])
User.create ({name: "Admin", email: "admin@releash.com", password: "password", password_confirmation: "password", role_id:3})
Species.create([{kind: 'Dog'}, {kind: 'Cat'}])
Breed.create([{name: 'Husky', species_id:1}, {name: 'Scottish Fold', species_id:2}]) 

#{kind: 'Golden Retriever'}, {kind: 'Labrador'}, {kind:'Unknown'}])
#CatBreed.create([{kind: 'American Shorthair'}, {kind: 'Scottish Fold'}, {kind: 'Ragdoll'}, {kind: 'Unknown'}])

