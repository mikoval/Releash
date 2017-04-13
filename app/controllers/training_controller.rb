class TrainingController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :newTraining
  def newTraining
  	@training = Training.new(train_params)

    if @training.current_entry?
      Training.update_all "current_entry = 'false'"
      @training.current_entry = true
      @new_status = StatusType.find_by(name: "In Training").id
      @trained_animal = Animal.find_by(id: @training.animal_id)
      
      if @training.sub_status_id != nil
        @new_sub_status = SubStatusType.find_by(id: @training.sub_status_id).id
      end
      
      @trained_animal.status_id = @new_status
      @trained_animal.sub_status_id = @new_sub_status
      @trained_animal.save
    end

    if @training.save
      flash[:success] = "Saved Training Entry"
      redirect_to :controller => "animals", :action => "profile", :param => @training.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @training.animal_id
    end
  end
  def train_params
  	params.require(:training).permit(:train_date, :problem_info, :animal_id, :trainer_id, :sub_status_id, :current_entry)
  end
  skip_before_filter :verify_authenticity_token, :only => :editTraining
  
  def editTraining
    @training = Training.find(params[:train_id])
    
    if @training.current_entry?
      Training.update_all "current_entry = 'false'"
      @training.current_entry = true
      @new_status = StatusType.find_by(name: "In Training").id
      @trained_animal = Animal.find_by(id: @training.animal_id)
      
      if @training.sub_status_id != nil
        @new_sub_status = SubStatusType.find_by(id: @training.sub_status_id).id
      end
      
      @trained_animal.status_id = @new_status
      @trained_animal.sub_status_id = @new_sub_status
      @trained_animal.save
    end

    if @training.update_attributes(train_params)
      
      flash[:success] = "Sucessful Edit"
      redirect_to :controller => "animals", :action => "profile", :param => @training.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @training.animal_id
    end
  end

  def list
  end
end
