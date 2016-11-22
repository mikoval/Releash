class PeopleController < ApplicationController
  def list
      @allPeople = User.all
      user = User.all
      
   
  end

  def new
  	 @employee = User.new
     @roles = Role.all
  end

  def people_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :role_id)
  end

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
