class AdoptedController < ApplicationController
  def new
  end

  skip_before_filter :verify_authenticity_token, :only => :newAdopted
  def newAdopted
    @adopted = Adopted.new(adopted_params)
    Rails.logger.debug("My adopted1--------------: #{@adopted.inspect}")
    
    if @adopted.current_entry?
      Adopted.update_all "current_entry = 'false'"
      @adopted.current_entry = true
      @new_status = StatusType.find_by(name: "With Adopter").id
      @adopted_animal = Animal.find_by(id: @adopted.animal_id)
      
      if @adopted.sub_status_id != nil
        @new_sub_status = SubStatusType.find_by(id: @adopted.sub_status_id).id
      end
      
      @adopted_animal.status_id = @new_status
      @adopted_animal.sub_status_id = @new_sub_status
      @adopted_animal.save
    end

    @adopter = params[:adopt_adopter][:adopt_id]

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
    Rails.logger.debug("My adopted--------------: #{@adopted.inspect}")
    
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
      params.require(:adopted).permit(:adopt_date, :adopter_id, :comments, :animal_id, :sub_status_id, :current_entry)
  end

  skip_before_filter :verify_authenticity_token, :only => :editAdopted
  
  def editAdopted
    @adopted = Adopted.find(params[:adopt_id])
    
    if @adopted.current_entry?
      Adopted.update_all "current_entry = 'false'"
      @adopted.current_entry = true
      @new_status = StatusType.find_by(name: "With Adopter").id
      @adopted_animal = Animal.find_by(id: @adopted.animal_id)
      
      if @adopted.sub_status_id != nil
        @new_sub_status = SubStatusType.find_by(id: @adopted.sub_status_id).id
      end
      
      @adopted_animal.status_id = @new_status
      @adopted_animal.sub_status_id = @new_sub_status
      @adopted_animal.save
    end

    @adopter = params[:adopt_adopter][:adopt_id]

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
