class TrainingController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :newTraining
  def newTraining
  	@training = Training.new(train_params)

    if @training.save
      flash[:success] = "Saved Training Entry"
      redirect_to :controller => "animals", :action => "profile", :param => @training.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @training.animal_id
    end
  end
  def train_params
  	params.require(:training).permit(:train_date, :problem_info, :animal_id, :trainer_id, :sub_status_id)
  end
  skip_before_filter :verify_authenticity_token, :only => :editTraining
  
  def editTraining
    #Rails.logger.debug("Params -----------------------------------: #{params.inspect}")
    @training = Training.find(params[:train_id])
    
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
