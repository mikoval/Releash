class PeopleController < ApplicationController
  # if you are wondering how these get called, look in routes. 

  #for the main people that displays all of them
  def list
   
      @allPeople = User.all
      user = User.all
  end

  #page for adding new people to the organization 
  def new
  	 @employee = User.new
     @roles = Role.all
  end

  #require says the type it has to be, for this one it has to have a user parameter
  #says the fields that are allowed. have to match up with column names
  def people_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :role_id, :picture)
  end
  # the code that actually adds an employee. 
  def addEmployee

    @people = User.new(people_params)
    if @people.save
      flash[:success] = "Added employee"
      redirect_to people_url
    else
      flash[:danger] = "Please fill out form correctly"
      redirect_to :controller => "people", :action => "new"
    end
  end



end
