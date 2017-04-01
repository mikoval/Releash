class VettingController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :newVetting
  def newVetting
  	@vetting = Vetting.new(vet_params)

    if @vetting.current_entry?
      Vetting.update_all "current_entry = 'false'"
      @new_status = StatusType.find_by(name: "Vetting").id
      @vetting_animal = Animal.find_by(id: @vetting.animal_id)
      
      if @vetting.sub_status_id != nil
        @new_sub_status = SubStatusType.find_by(id: @vetting.sub_status_id).id
      end
      
      @vetting_animal.status_id = @new_status
      @vetting_animal.sub_status_id = @new_sub_status
      @vetting_animal.save
    end

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
    
    if @vetting.current_entry?
      Vetting.update_all "current_entry = 'false'"
      @new_status = StatusType.find_by(name: "Vetting").id
      @vetting_animal = Animal.find_by(id: @vetting.animal_id)
    
    if @vetting.sub_status_id != nil
      @new_sub_status = SubStatusType.find_by(id: @vetting.sub_status_id).id
    end
    
      @vetting_animal.status_id = @new_status
      @vetting_animal.sub_status_id = @new_sub_status
      @vetting_animal.save
    end

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
