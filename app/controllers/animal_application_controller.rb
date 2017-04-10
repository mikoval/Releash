class AnimalApplicationController < ApplicationController
  def new
  end

  skip_before_filter :verify_authenticity_token, :only => :newApp
  
  def newApp
    @animal_app = AnimalApplication.new(app_params)
    #Rails.logger.debug("My adopted1--------------: #{@animal_app.save!.inspect}")
    
    @adopter = params[:app_adopter][:adopt_id]

    if User.where(email: @adopter) != []
      @temp = User.where(email: @adopter)
      @adopt_adopter = Adopter.where(user_id: @temp.ids)
      @animal_app.adopter_id = @adopt_adopter.ids[0]
    end
    if NonUser.where(email: @adopter) != []
      @temp = NonUser.where(email: @adopter)
      @adopt_adopter = Adopter.where(non_user_id: @temp.ids)
      @animal_app.adopter_id = @adopt_adopter.ids[0]
    end
    
    if @animal_app.save
      flash[:success] = "Saved Appication"
      redirect_to :controller => "animals", :action => "profile", :param => @animal_app.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @animal_app.animal_id
    end
  end

  def list
  end

  def app_params
      params.require(:animal_application).permit(:app_date,:animal_id, :adoption_document, :comments, :adopter_id, :text_app)
  end

  skip_before_filter :verify_authenticity_token, :only => :editApp
  
  def editApp
    @animal_app = AnimalApplication.find(params[:app_id])
    
    @adopter = params[:app_adopter][:adopter_id]

    if User.where(email: @adopter) != []
      @temp = User.where(email: @adopter)
      @adopt_adopter = Adopter.where(user_id: @temp.ids)
      @animal_app.adopter_id = @adopt_adopter.ids[0]
    end
    if NonUser.where(email: @adopter) != []
      @temp = NonUser.where(email: @adopter)
      @adopt_adopter = Adopter.where(non_user_id: @temp.ids)
      @animal_app.adopter_id = @adopt_adopter.ids[0]
    end
    
    if @animal_app.update_attributes(app_params)
      
      flash[:success] = "Sucessful Edit"
      redirect_to :controller => "animals", :action => "profile", :param => @animal_app.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @animal_app.animal_id
    end
  end

end
