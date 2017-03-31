class IntakeController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :new
  
  def new
    Rails.logger.debug("My object:---------------------")
  	@intake = Intake.new
  	@fosters_user = User.where(foster_check: true)
    @foster_non_user = NonUser.where(foster_check: true)
    @sub_status = SubStatusType.all
    
    @fosters = @fosters_user + @foster_non_user
    #Rails.logger.debug("My object: #{@fosters.inspect}")
    @adopt_user = User.where(adopt_check: true)
    @adopt_non_user = NonUser.where(adopt_check: true)
    @adopters = @adopt_user + @adopt_non_user

    @trainers = Trainer.all
    @vets = Veterinarian.all
  end
  skip_before_filter :verify_authenticity_token, :only => :newIntake
  
  def newIntake
    @fosters_user = User.where(foster_check: true)
    @foster_non_user = NonUser.where(foster_check: true)
    @sub_status = SubStatusType.all
    
    @fosters = @fosters_user + @foster_non_user
    #Rails.logger.debug("My object: #{@fosters.inspect}")
    @adopt_user = User.where(adopt_check: true)
    @adopt_non_user = NonUser.where(adopt_check: true)
    @adopters = @adopt_user + @adopt_non_user

  	@intake = Intake.new(intake_params)

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
  
  def edit
  end

  def list
  end
end
