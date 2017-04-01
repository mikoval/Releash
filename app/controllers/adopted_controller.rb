class AdoptedController < ApplicationController
  def new
  end

skip_before_filter :verify_authenticity_token, :only => :newAdopted
  def newAdopted
    @adopted = Adopted.new(adopted_params)

    if @adopted.save
      flash[:success] = "Saved Adoption Entry"
      redirect_to :controller => "animals", :action => "profile", :param => @adopted.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @adopted.animal_id
    end
  end

  def edit
  end

  def list
  end

def adopted_params
    params.require(:adopted).permit(:adopt_date, :adopter_id, :comments, :animal_id, :sub_status_id)
  end

end
