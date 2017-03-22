class NonUserController < ApplicationController
  def profile
    @non_user = NonUser.find(params["param"])
    
    if @non_user.address != nil and @non_user.state != nil and @non_user.zip_code != nil
      @full_address = @non_user.address + " " + @non_user.state + " " + @non_user.zip_code.to_s
    else
      @full_address = nil
    end
    @foster_ok = @non_user.foster_check
    
    #Rails.logger.debug("My object: #{@foster_ok.inspect}")
    
    @adopt_ok = @non_user.adopt_check
  end

  def edit
    @non_user = NonUser.find(params["param"])
  end

  def new
    @non_user = NonUser.new()
  end

  def list
    @allUser = NonUser.all
  end

  def newUser
    @non_user = NonUser.new(user_params)

    if @non_user.save
      flash[:success] = "Added Non User"
      redirect_to :controller => "non_user", :action => "profile", :param => @non_user
    else
      render 'new'
    end
  end
  
  def editUser
    @non_user = NonUser.find(params["format"])

    if @non_user.update_attributes(user_params)
      flash[:success] = "Sucessful Edit"
      redirect_to :controller => "non_user", :action => "profile", :param => @non_user
    else
      render 'edit'
    end
  end
  
  def query
    @users = NonUser.all.limit(10)
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
  
  def user_params
  	params.require(:non_user).permit(:name,:address,:state, :zip_code, :email, :picture, 
                                    :foster_check, :adopt_check)
  end

end
