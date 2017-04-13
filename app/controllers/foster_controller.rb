class FosterController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :newFoster
  
  def newFoster
  	@new_foster = FosterStatus.new(foster_params)
    
    if @new_foster.current_entry?
      FosterStatus.update_all "current_entry = 'false'"
      @new_foster.current_entry = true
      
      @new_status = StatusType.find_by(name: "Foster").id
      @foster_animal = Animal.find_by(id: @new_foster.animal_id)
      
      if @new_foster.sub_status_id != nil
        @new_sub_status = SubStatusType.find_by(id: @new_foster.sub_status_id).id
      end
      
      @foster_animal.status_id = @new_status
      @foster_animal.sub_status_id = @new_sub_status
      @foster_animal.save
    end

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
  	params.require(:foster_status).permit(:foster_date, :foster_id, :comments, :animal_id, :sub_status_id, :current_entry)
  end

  skip_before_filter :verify_authenticity_token, :only => :editFoster
  
  def editFoster
    @edit_foster = FosterStatus.find(params[:fost_id])
    
    if @edit_foster.current_entry?
      FosterStatus.update_all "current_entry = 'false'"
      @edit_foster.current_entry = true
      @new_status = StatusType.find_by(name: "Foster").id
      
      @foster_animal = Animal.find_by(id: @edit_foster.animal_id)
      
      if @edit_foster.sub_status_id != nil
        @new_sub_status = SubStatusType.find_by(id: @edit_foster.sub_status_id).id
      end
      
      @foster_animal.status_id = @new_status
      @foster_animal.sub_status_id = @new_sub_status
      @foster_animal.save
    end

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
