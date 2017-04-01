class AdoptedController < ApplicationController
  def new
  end

  skip_before_filter :verify_authenticity_token, :only => :newAdopted
  def newAdopted
    @adopted = Adopted.new(adopted_params)
    @adopter = params[:adopt_adopter][:adopter_id]

    if User.where(email: @adopter) != []
      @temp = User.where(email: @adopter)
      @adopt_adopter = Adopter.where(user_id: @temp.ids)
      @adopted.adopter_id = @adopt_adopter.ids[0]
    end
    if NonUser.where(email: @adopter) != []
      @temp = NonUser.where(email: @adopter)
      @adopt_adopter = Adopter.where(non_user_id: @temp.ids)
      @adopted.adopter_id = @adopt_adopter.ids[0]
    end

    if @adopted.save
      flash[:success] = "Saved Adoption Entry"
      redirect_to :controller => "animals", :action => "profile", :param => @adopted.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @adopted.animal_id
    end
  end

  def list
  end

  def adopted_params
      params.require(:adopted).permit(:adopt_date, :adopter_id, :comments, :animal_id, :sub_status_id)
  end

  skip_before_filter :verify_authenticity_token, :only => :editAdopted
  
  def editAdopted
    #Rails.logger.debug("Params -----------------------------------: #{params.inspect}")
    @adopted = Adopted.find(params[:adopt_id])
    
    @adopter = params[:adopt_adopter][:adopter_id]

    if User.where(email: @adopter) != []
      @temp = User.where(email: @adopter)
      @adopt_adopter = Adopter.where(user_id: @temp.ids)
      @adopted.adopter_id = @adopt_adopter.ids[0]
    end
    if NonUser.where(email: @adopter) != []
      @temp = NonUser.where(email: @adopter)
      @adopt_adopter = Adopter.where(non_user_id: @temp.ids)
      @adopted.adopter_id = @adopt_adopter.ids[0]
    end
    
    if @adopted.update_attributes(adopted_params)
      
      flash[:success] = "Sucessful Edit"
      redirect_to :controller => "animals", :action => "profile", :param => @adopted.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @adopted.animal_id
    end
  end

end
