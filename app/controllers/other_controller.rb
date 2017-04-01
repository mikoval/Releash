class OtherController < ApplicationController
  def new
  end
  
  skip_before_filter :verify_authenticity_token, :only => :newOther
  def newOther
    @other = OtherStatus.new(other_params)

    if @other.current_entry?
      OtherStatus.update_all "current_entry = 'false'"
      @new_status = StatusType.find_by(name: "Other").id
      @other_animal = Animal.find_by(id: @other.animal_id)
      
      if @other.sub_status_id != nil
        @new_sub_status = SubStatusType.find_by(id: @other.sub_status_id).id
      end
      
      @other_animal.status_id = @new_status
      @other_animal.sub_status_id = @new_sub_status
      @other_animal.save
    end

    if @other.save
      flash[:success] = "Saved Other Entry"
      redirect_to :controller => "animals", :action => "profile", :param => @other.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @other.animal_id
    end
  end

  def list
  end

  def other_params
    params.require(:other_status).permit(:other_date, :status_name, :sub_status_id, :comments, :animal_id)
  end

  skip_before_filter :verify_authenticity_token, :only => :editOther
  
  def editOther
    #Rails.logger.debug("Params -----------------------------------: #{params.inspect}")
    @other = OtherStatus.find(params[:other_id])
    if @other.current_entry?
      OtherStatus.update_all "current_entry = 'false'"
      @new_status = StatusType.find_by(name: "Other").id
      @other_animal = Animal.find_by(id: @other.animal_id)
      
      if @other.sub_status_id != nil
        @new_sub_status = SubStatusType.find_by(id: @other.sub_status_id).id
      end
      
      @other_animal.status_id = @new_status
      @other_animal.sub_status_id = @new_sub_status
      @other_animal.save
    end

    if @other.update_attributes(other_params)
      
      flash[:success] = "Sucessful Edit"
      redirect_to :controller => "animals", :action => "profile", :param => @other.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @other.animal_id
    end
  end

end
