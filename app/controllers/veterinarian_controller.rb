class VeterinarianController < ApplicationController
  def profile
    @vet = Veterinarian.find(params["param"])
    
    if @vet.address != nil and @vet.state != nil and @vet.zip_code != nil
      @full_address = @vet.address + " " + @vet.state + " " + @vet.zip_code.to_s
    else
      @full_address = nil
    end
  end
  
  def new
  	@vet = Veterinarian.new()
  end

  def list
  	@allVets = Veterinarian.all
  end

  def edit
  	@vet = Veterinarian.find(params["param"])
  end

  def newVet
  	@vet = Veterinarian.new(vet_params)

    if @vet.save
      flash[:success] = "Added Vet"
      redirect_to :controller => "people", :action => "list", :param => @vet
    else
      render 'new'
    end
  end
  
  def editVet
  	@vet = Veterinarian.find(params["format"])
    
    if @vet.update_attributes(vet_params)
      flash[:success] = "Added Vet"
      redirect_to :controller => "people", :action => "list", :param => @vet
    else
      render 'edit'
    end
  	
  end

  def vet_params
  	params.require(:veterinarian).permit(:name, :address , :city , :state, :zip_code, :email, :phone_number, :person_contact, :comments, :credit_card)
  end
end
