class FosterController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :newFoster
  
  def newFoster
  	@foster = FosterStatus.new(foster_params)

    if @foster.save
      flash[:success] = "Saved Foster Entry"
      redirect_to :controller => "animals", :action => "profile", :param => @foster.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @foster.animal_id
    end

  end

  def foster_params
  	params.require(:foster_status).permit(:foster_date, :foster_id, :vet_id, :comments, :animal_id, :sub_status_id, :homecheck)
  end

  def edit
  end

  def list
  end
end
