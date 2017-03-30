class IntakeController < ApplicationController
  def new
  	@intake = Intake.new
  	@fosters_user = User.where(foster_check: true)
    @foster_non_user = NonUser.where(foster_check: true)
    #Rails.logger.debug("My object: #{foster_non_user.inspect}")
    @fosters = @fosters_user + @foster_non_user
    #Rails.logger.debug("My object: #{@fosters.inspect}")
    @adopt_user = User.where(adopt_check: true)
    @adopt_non_user = NonUser.where(adopt_check: true)
    @adopters = @adopt_user + @adopt_non_user

    @trainers = Trainer.all
    @vets = Veterinarian.all
  end

  def newIntake
  	@intake = Intake.new(intake_params)

  	respond_to do |format|
	    if @non_user.save
	      format.html { redirect_to @intake, notice: 'Entry Created Successfully' }
	      format.json { render action: 'show', status: :created, location: @intake }
	       # added:
	      format.js   { render action: 'show', status: :created, location: @intake }
	    else
	      format.html { render action: 'new' }
	      format.json { render json: @intake.errors, status: :unprocessable_entity }
	      # added:
	      format.js   { render json: @intake.errors, status: :unprocessable_entity }
	    end
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
