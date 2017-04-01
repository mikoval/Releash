class VettingController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :newVetting
  def newVetting
  	@vetting = Vetting.new(vet_params)

    if @vetting.save
      flash[:success] = "Saved Vetting Entry"
      redirect_to :controller => "animals", :action => "profile", :param => @vetting.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @vetting.animal_id
    end
  end
  def vet_params
  	params.require(:vetting).permit(:vet_date, :curr_vet_id, :comments, :animal_id, :sub_status_id)
  end

  skip_before_filter :verify_authenticity_token, :only => :editVetting
  
  def editVetting
    #Rails.logger.debug("Params -----------------------------------: #{params.inspect}")
    @vetting = Vetting.find(params[:vet_id])
    
    if @vetting.update_attributes(vet_params)
      
      flash[:success] = "Sucessful Edit"
      redirect_to :controller => "animals", :action => "profile", :param => @vetting.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @vetting.animal_id
    end
  end

  def list
  end
end
