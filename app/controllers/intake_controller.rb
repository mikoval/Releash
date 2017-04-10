class IntakeController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :newIntake
  
  def newIntake

  	@intake = Intake.new(intake_params)
    @foster = params[:intake_fost][:foster_id]
    
    if @intake.current_entry?

      @intake_animal = Animal.find_by(id: @intake.animal_id)
      Intake.update_all "current_entry = 'false'"

      @new_status = StatusType.find_by(name: "Intake").id
      
      if @intake.sub_status_id != nil
        @new_sub_status = SubStatusType.find_by(id: @intake.sub_status_id).id
      end
      
      @intake_animal.status_id = @new_status
      @intake_animal.sub_status_id = @new_sub_status
      @intake_animal.save
    end
    
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
  	params.require(:intake).permit(:intake_date, :foster_id, :vet_id, :comments, :animal_id, :sub_status_id, :animal_facility_id, :current_entry, :intake_reason_id)
  end
  
  skip_before_filter :verify_authenticity_token, :only => :editIntake
  
  def editIntake
    #Rails.logger.debug("Params -----------------------------------: #{params.inspect}")
    @intake = Intake.find(params[:intake_id])
    
    if @intake.current_entry?
      Intake.update_all "current_entry = 'false'"

      @intake_animal = Animal.find_by(id: @intake.animal_id)

      @new_status = StatusType.find_by(name: "Intake").id
      
      if @intake.sub_status_id != nil
        @new_sub_status = SubStatusType.find_by(id: @intake.sub_status_id).id
      end
      
      @intake_animal.status_id = @new_status
      @intake_animal.sub_status_id = @new_sub_status
      @intake_animal.save
    end

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
