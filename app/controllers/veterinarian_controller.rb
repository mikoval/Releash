class VeterinarianController < ApplicationController
  def new
  	@vet = Veterinarian.new()
  end

  def list
  	@allVet - Veterinarian.all
  end

  def edit
  	@vet = Veterinarian.find(params["param"])
  end

  def newVet
  	@vet = Veterinarian.new(vet_params)

    if @vet.save
      flash[:success] = "Added Vet"
      redirect_to :controller => "veterinarian", :action => "list", :param => @vet
    else
      render 'new'
    end
  end
  
  def editVet
  	@vet = Veterinarian.find(params["format"])
    
    if @vet.update_attributes(vet_params)
      flash[:success] = "Added Vet"
      redirect_to :controller => "veterinarian", :action => "list", :param => @vet
    else
      render 'edit'
    end
  	
  end

  def vet_params
  	params.require(:veterinarian).permit(:name, :address , :city , :state, :zip_code, :email)
  end
end
