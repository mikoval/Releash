class AnimalFacilityController < ApplicationController
  def profile
    @ani_faci = AnimalFacility.find(params["param"])
    
    if @ani_faci.address != nil and @ani_faci.state != nil and @ani_faci.zip_code != nil
      @full_address = @ani_faci.address + " " + @ani_faci.state + " " + @ani_faci.zip_code.to_s
    else
      @full_address = nil
    end
  end
  def new
  	@ani_faci = AnimalFacility.new()
  end

  def list
  	@allAniFaci= AnimalFacility.all
  end

  def edit
  	@ani_faci = AnimalFacility.find(params["param"])
  end

  def newAnifaci
  	@ani_faci = AnimalFacility.new(ani_faci_params)

    if @ani_faci.save
      flash[:success] = "Added Animal Facility"
      redirect_to :controller => "people", :action => "list", :param => @ani_faci
    else
      render 'new'
    end
  end
  
  def editAnifaci
  	@ani_faci = AnimalFacility.find(params["format"])
    
    if @ani_faci.update_attributes(anifaci_params)
      flash[:success] = "Added Animal Facility"
      redirect_to :controller => "people", :action => "list", :param => @ani_faci
    else
      render 'edit'
    end
  	
  end

  def anifaci_params
  	params.require(:animal_facility).permit(:name, :address , :city , :state, :zip_code, :email, :phone_number)
  end
end
