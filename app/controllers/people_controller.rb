class PeopleController < ApplicationController
   skip_before_filter :verify_authenticity_token, :only => :dashboardSave
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
     puts "ROLES ARE GOING NOW"
  end

  def edit
    @employee = User.find(params["param"])
    @roles = Role.all
  end
  
   def profile
    @employee = User.find(params["param"])
  end
  #require says the type it has to be, for this one it has to have a user parameter
  #says the fields that are allowed. have to match up with column names
  def people_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :role_id, :picture, :disabled)
  end
  # the code that actually adds an employee. 
  def addEmployee

    @employee = User.new(people_params)

    
    
    if @employee.save
      UserMailer.account_activation(@employee, current_user).deliver_now
      flash[:success] = "Added employee"
      redirect_to people_url
    else
      @roles = Role.all
      render 'new'
    end
  end

def editEmployee
    @employee = User.find(params["format"])

    if @employee.update_attributes(people_params)
      flash[:success] = "Saved employee"
      redirect_to people_url
    else
      @roles = Role.all
      render 'edit'
    end
  end
def dashboardSave
    str = params["str"]
    
    
    @employee = User.where("id =  " + current_user.id.to_s).update_all( dashboard: str )
   

    render json: params

end
def dashboardGet
  json = {"str": current_user.dashboard}
  render json: json
end

def query
    @users = User.all.limit(10)
    arr = []
    @users.each do |d|
      arr.push({
        "id" =>  d.id, 
        "name" => d.name,
        "email" => d.email,

      })
    end
    render json: arr
  end

end


