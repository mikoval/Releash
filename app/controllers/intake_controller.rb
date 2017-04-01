class IntakeController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :newIntake
  
  def newIntake

  	@intake = Intake.new(intake_params)
    #Rails.logger.debug("Params -----------------------------------: #{params[:intake_fost].inspect}")
    @foster = params[:intake_fost][:foster_id]

    if User.where(email: @foster) != []
      @temp = User.where(email: @foster)
      @intake_foster = Foster.where(user_id: @temp.ids)
      @intake.foster_id = @intake_foster.ids[0]
    end
    if NonUser.where(email: @foster) != []
      @temp = NonUser.where(email: @foster)
      @intake_foster = Foster.where(non_user_id: @temp.ids)
      @intake.foster_id = @intake_foster.ids[0]
    end

    if @intake.save
      flash[:success] = "Saved Intake Entry"
      redirect_to :controller => "animals", :action => "profile", :param => @intake.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @intake.animal_id
    end

  end

  def intake_params
  	params.require(:intake).permit(:intake_date, :foster_id, :vet_id, :comments, :animal_id, :sub_status_id, :animal_facility_id)
  end
  
  skip_before_filter :verify_authenticity_token, :only => :editIntake
  
  def editIntake
    #Rails.logger.debug("Params -----------------------------------: #{params.inspect}")
    @intake = Intake.find(params[:intake_id])
    
    @foster = params[:intake_fost][:foster_id]

    if User.where(email: @foster) != []
      @temp = User.where(email: @foster)
      @intake_foster = Foster.where(user_id: @temp.ids)
      @intake.foster_id = @intake_foster.ids[0]
    end
    if NonUser.where(email: @foster) != []
      @temp = NonUser.where(email: @foster)
      @intake_foster = Foster.where(non_user_id: @temp.ids)
      @intake.foster_id = @intake_foster.ids[0]
    end
    
    if @intake.update_attributes(intake_params)
      
      flash[:success] = "Sucessful Edit"
      redirect_to :controller => "animals", :action => "profile", :param => @intake.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @intake.animal_id
    end
  end

  def list
  end
end
