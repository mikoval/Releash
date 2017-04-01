class OtherController < ApplicationController
  def new
  end
  
  skip_before_filter :verify_authenticity_token, :only => :newOther
  def newOther
    @other = OtherStatus.new(other_params)

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
    
    if @other.update_attributes(other_params)
      
      flash[:success] = "Sucessful Edit"
      redirect_to :controller => "animals", :action => "profile", :param => @other.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @other.animal_id
    end
  end

end
