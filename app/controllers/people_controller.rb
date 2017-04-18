class PeopleController < ApplicationController
   skip_before_filter :verify_authenticity_token, :only => :dashboardSave
  # if you are wondering how these get called, look in routes. 

  #for the main people that displays all of them
  def list
   
    @allPeople = User.all.order('name ASC')
    @allNonUser = NonUser.all.order('name ASC')
    @allVets = Veterinarian.all.order('name ASC')
    @allTrainer = Trainer.all.order('name ASC')
    @allAniFaci = AnimalFacility.all.order('name ASC')
    user = User.all.order('name ASC')
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

    if @employee.address != nil and @employee.city != nil and @employee.state != nil and @employee.zip_code != nil
      @full_address = @employee.address.to_s + " " + @employee.city.to_s + " " + @employee.state.to_s + " " + @employee.zip_code.to_s

    else
      @full_address = nil
    end
    @foster_ok = @employee.foster_check
    @adopt_ok = @employee.adopt_check

    @foster = Foster.find_by user_id: @employee.id
    if @foster != nil
      @allFosters = FosterStatus.where(foster_id: @foster.id).order('foster_date DESC')

    end

    @adoptions = Adopter.find_by user_id: @employee.id

    if @adoptions != nil
      @allAdoptions = Adopted.where(adopter_id: @adoptions.id).order('adopt_date DESC')
      @allApps = AnimalApplication.where(adopter_id: @adoptions.id).order('app_date DESC')
 
    end
  end

  def people_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :role_id, :picture, :disabled, :address, :city,
                                   :state, :zip_code, :foster_check, :adopt_check, :comments, :home_comm, :homecheck, :phone_number, :user_document)
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


