class PeopleController < ApplicationController
   skip_before_filter :verify_authenticity_token, :only => :dashboardSave
  # if you are wondering how these get called, look in routes. 

  #for the main people that displays all of them
  def list
   
      @allPeople = User.all
      @allNonUser = NonUser.all
      @allVets = Veterinarian.all
      @allTrainer = Trainer.all
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
    
    if @employee.address != nil and @employee.state != nil and @employee.zip_code != nil
      @full_address = @employee.address + " " + @employee.state + " " + @employee.zip_code
    else
      @full_address = nil
    end
    @foster_ok = @employee.foster_check
    
    #Rails.logger.debug("My object: #{@foster_ok.inspect}")
    
    @adopt_ok = @employee.adopt_check
  end
  #require says the type it has to be, for this one it has to have a user parameter
  #says the fields that are allowed. have to match up with column names
  def people_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :role_id, :picture, :disabled, :address,
                                   :state, :zip_code, :foster_check, :adopt_check)
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

      if @employee.foster_check = true
          #if they weren't approved for a foster at first but now are
          @new_foster = Foster.new({non_user_id: nil, user_id: @employee.id,})
          @new_foster.save
      end
      
      if @employee.adopt_check = true
        #if they weren't approved for a adopter at first but now are
        @new_adopter = Adopter.new({non_user_id: nil, user_id: @employee.id,})
        @new_adopter.save
      end 

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
  json = {"str" => current_user.dashboard}
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


