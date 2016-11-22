#  this is where you put in values that you want in the database when created. 
# run 'rake db:seed'
Role.create([{title: 'Volunteer'}, {title: 'Employee'}, {title: 'Administrator '}])
User.create ({name: "Admin", email: "admin@releash.com", password: "password", password_confirmation: "password", role_id:3})
