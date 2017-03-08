class AnimalsController < ApplicationController
  def list
    @animal = Animal.new
    @allAnimals = Animal.all
  end

  def new
    @animal = Animal.new
    
    @status = StatusType.all
    @hold = HoldType.all
    
    @breed = Breed.order('name ASC')
    @behavior = Characteristic.where("category = 'Behavior'")
    @attribute = Characteristic.where("category = 'Attribute'")


  end

  def edit
    @animal = Animal.find(params["param"])
    @status = StatusType.all
    @breed = Breed.order('name ASC')
    @breeds = AnimalBreed.where("animal_id = " + params["param"])
    @behavior = Characteristic.where("category = 'Behavior'")
    @attribute = Characteristic.where("category = 'Attribute'")


    @characteristics = AnimalCharacteristic.where("animal_id = " + params["param"])
    @attributes = []
    @behaviors = []
    @characteristics.each do |d|

      if(d.characteristic.category == "Attribute")
        @attributes.push(d)
      else 
        @behaviors.push(d)
      end
    end

  end
  
  def profile
    @animal = Animal.find(params["param"])

    #checking status to display correct one
    @status = StatusType.find(@animal.status_id)
    @status_name = @status.name
    #Rails.logger.debug("My object: #{status_name.inspect}")
    
    if (@status_name.to_s == "Intake")
      @intake = Intake.find(@animal.id)
      @intake_foster = User.find(@intake.foster_id).name
      @intake_vet = Veterinarian.find(@intake.vet_id).name
      @intake_hold = HoldType.find(@intake.intake_hold_id).name
      Rails.logger.debug("My object: #{@intake.inspect}")
    end
    
    @breeds = AnimalBreed.where("animal_id = " + params["param"])
    @characteristics = AnimalCharacteristic.where("animal_id = " + params["param"])
    @attributes = []
    @behaviors = []

    @characteristics.each do |d|

      if(d.characteristic.category == "Attribute")
        @attributes.push(d)
      else 
        @behaviors.push(d)
      end
    end


  end


  def newAnimal
    @animal = Animal.new(animal_params)
    @status = StatusType.all
    @allAnimals = Animal.all
    @breed = Breed.all
    @users = User.all


    if @animal.save
      #this code was for old documents
      if params["breeds"]
        arr = params["breeds"].split("|")
        arr.each do |d|
          
        @breed = AnimalBreed.new({animal_id: @animal.id, breed_id: d})
        @breed.save
        end
      end

      if params["intake_dt"]

        @intake = params[:intake_dt]
        @foster = params[:intake_fost][:user_id]
        @vet = params[:intake_vet][:veterinarian_id]
        #@comm = params[:intake_comm]["{:class=>%22form-control%22}"]
        @comm = params[:intake_cm]
        @hold = params[:intake_hold][:hold_type_id]

        @new_intake = Intake.new({intake_date: @intake, intake_date: @intake, foster_id: @foster,
                      vet_id: @vet, comments: @comm, intake_hold_id: @hold, animal_id: @animal.id})
        @new_intake.save
        @testing = Intake.all
        Rails.logger.debug("My object: #{@new_intake.inspect}")


      end
      
      if params["behavior"]
        arr = params["behavior"].split("|")
        arr.each do |d|
          
        @Characteristic = AnimalCharacteristic.new({animal_id: @animal.id, characteristic_id: d})
        @Characteristic.save
        end
      end
      if params["attribute"]
        arr = params["attribute"].split("|")
        arr.each do |d|
          
        @Characteristic = AnimalCharacteristic.new({animal_id: @animal.id, characteristic_id: d})
        @Characteristic.save
        end
      end


      flash.now[:success] = "New Animal!"
      redirect_to :controller => "animals", :action => "profile", :param => @animal

      
        

    else
      flash.now[:danger] = "Error adding Animal!"
      render 'new'
    end
  end

  def editAnimal
    @animal = Animal.find(params["format"])
    

    if @animal.update_attributes(animal_params)
       AnimalBreed.where("animal_id = " + @animal.id.to_s).delete_all
       AnimalCharacteristic.where("animal_id = " + @animal.id.to_s).delete_all

      if params["breeds"]
        arr = params["breeds"].split("|")
        arr.each do |d|
        
        @breed = AnimalBreed.new({animal_id: @animal.id, breed_id: d})
        @breed.save
        end
      end
      if params["behavior"]
        arr = params["behavior"].split("|")
        arr.each do |d|
          
        @Characteristic = AnimalCharacteristic.new({animal_id: @animal.id, characteristic_id: d})
        @Characteristic.save
        end
      end
      if params["attribute"]
        arr = params["attribute"].split("|")
        arr.each do |d|
          
        @Characteristic = AnimalCharacteristic.new({animal_id: @animal.id, characteristic_id: d})
        @Characteristic.save
        end
      end

      flash[:success] = "Saved animal"
      redirect_to :controller => "animals", :action => "profile", :param => @animal
    else
      flash.now[:danger] = "Error editing animal!"
      @breed = Breed.all
      render 'edit'
    end
  end

  def query
    @animals = Animal.all.limit(10)
    arr = []
    @animals.each do |d|
      sBreed = '';
      if(d.secondary_breed_id)
        sBreed = d.secondary_breed.name
      end

      arr.push({
        "id" =>  d.id, 
        "name" => d.name,
        "primary" => d.primary_breed.name,
        "secondary" => sBreed,
        "picture" => d.picture,
      })
    end
    render json: arr
  end

  def search
    @search = params["q"]
    if (@search != "")
      @breed = Breed.where('LOWER(name) LIKE LOWER(:search)', search: "%#{@search}%" )
      
      if(@breed.length > 0)
        breedid = @breed.ids
      else 
        breedid = 0
      end
      
      @animal = Animal.where('LOWER(name) LIKE LOWER(:search)' , search: "%#{@search}%")
      @breeds = Animal.where(primary_breed_id: breedid)
      
      @animals = @animal | @breeds
      @user = User.where('LOWER(name) LIKE LOWER(:search)' , search: "%#{@search}%")
    end


    arr = []
    if (!@animals.nil?) 
      @animals.each do |d|
        sBreed = '';
        if(d.secondary_breed_id)
          sBreed = d.secondary_breed.name
        end
        arr.push({
          "check" => "animal",
          "id" =>  d.id, 
          "name" => d.name,
          "attribute" => d.primary_breed.name,
          "picture" => d.picture,
        })
      end
    end
    if (!@user.nil?) 
      @user.each do |d|
        arr.push({
          "check" => "user",
          "id" =>  d.id, 
          "name" => d.name,
          "attribute" => d.email,
          "picture" => d.picture,
        })
      end
    end
    render json: arr

  end
  private

  def animal_params

    params.require(:animal).permit(:name, :primary_breed_id, :secondary_breed_id, :picture, :status_id, :color_primary, :color_secondary, :eye_color,
      :adoption_fee, :animal_type, :birthday, :cage_number, :microchip_number, :tag_number, :neutered,  

      :intake_document, :owner_surrender_document, :home_check_document, :match_application_document, :adoption_application_document, 
      :adoption_contract_document, :vetting_document, :intake_date
      )

  end
end

