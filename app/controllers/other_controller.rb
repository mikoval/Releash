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

  def edit
  end

  def list
  end

  def other_params
    params.require(:other_status).permit(:other_date, :sub_status_id, :comments, :animal_id)
  end
end
