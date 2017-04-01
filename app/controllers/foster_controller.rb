class FosterController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :newFoster
  
  def newFoster
  	@new_foster = FosterStatus.new(foster_params)
    
    @foster = params[:fost_fost][:foster_id]

    if User.where(email: @foster) != []
      @temp = User.where(email: @foster)
      @fost_foster = Foster.where(user_id: @temp.ids)
      @new_foster.foster_id = @fost_foster.ids[0]
    end
    if NonUser.where(email: @foster) != []
      @temp = NonUser.where(email: @foster)
      @fost_foster = Foster.where(non_user_id: @temp.ids)
      @new_foster.foster_id = @fost_foster.ids[0]
    end

    if @new_foster.save
      flash[:success] = "Saved Foster Entry"
      redirect_to :controller => "animals", :action => "profile", :param => @new_foster.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @new_foster.animal_id
    end

  end

  def foster_params
  	params.require(:foster_status).permit(:foster_date, :foster_id, :vet_id, :comments, :animal_id, :sub_status_id, :homecheck)
  end

  skip_before_filter :verify_authenticity_token, :only => :editFoster
  
  def editFoster
    #Rails.logger.debug("Params -----------------------------------: #{params.inspect}")
    @edit_foster = FosterStatus.find(params[:fost_id])
    
    @foster = params[:fost_fost][:foster_id]

    if User.where(email: @foster) != []
      @temp = User.where(email: @foster)
      @fost_foster = Foster.where(user_id: @temp.ids)
      @edit_foster.foster_id = @fost_foster.ids[0]
    end
    if NonUser.where(email: @foster) != []
      @temp = NonUser.where(email: @foster)
      @fost_foster = Foster.where(non_user_id: @temp.ids)
      @edit_foster.foster_id = @fost_foster.ids[0]
    end
    
    if @edit_foster.update_attributes(foster_params)
      
      flash[:success] = "Sucessful Edit"
      redirect_to :controller => "animals", :action => "profile", :param => @edit_foster.animal_id
    else
      redirect_to :controller => "animals", :action => "profile", :param => @edit_foster.animal_id
    end
  end

  def list
  end
end
