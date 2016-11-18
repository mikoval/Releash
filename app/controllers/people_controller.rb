class PeopleController < ApplicationController
  def list
      @allPeople = User.all
  end

  def new
  	 @employee = User.new
  end

  def people_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :role)
  end

  def addEmployee
    @people = User.new(people_params)
    if @people.save
      flash[:success] = "Added employee"
      redirect_to people_url
    else
      redirect_to people_url
    end
  end



end
