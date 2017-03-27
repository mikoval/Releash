class AnimalsController < ApplicationController
  def list
    @animal = Animal.new
    @allAnimals = Animal.all
  end

  def new
    @animal = Animal.new
    
    @status = StatusType.all
    @hold = HoldType.all
    @breed = Breed.where("name != 'Mixed'").order('name ASC')
    @mixed = Breed.where("name = 'Mixed'")

    @primary = []
    @secondary = []
    @secondary.push(@mixed[0])
    @breed.each do |b|
      @primary.push(b)
      @secondary.push(b)
    end


    @behavior = Characteristic.where("category = 'Behavior'")
    @attribute = Characteristic.where("category = 'Attribute'")


  end

  def edit
    @animal = Animal.find(params["param"])
    @status = StatusType.all

    @breed = Breed.where("name != 'Mixed'").order('name ASC')
    @mixed = Breed.where("name = 'Mixed'")

    @primary = []
    @secondary = []
    @secondary.push(@mixed[0])
    @breed.each do |b|
      @primary.push(b)
      @secondary.push(b)
    end

    @breeds = AnimalBreed.where("animal_id = " + params["param"])
    @behavior = Characteristic.where("category = 'Behavior'")
    @attribute = Characteristic.where("category = 'Attribute'")


    @characteristics = AnimalCharacteristic.where("animal_id = " + params["param"])
    @attributes = []
    @behaviors = []
    @characteristics.each do |d|

      if(d.characteristic.category == "Attribute")

        @attributes.push(d.characteristic)
      else 
        @behaviors.push(d.characteristic)
      end
    end

  end
  
  def profile
    id = params["param"]
    @animal = Animal.find(id)

    @breeds = AnimalBreed.where("animal_id = " + id)
    @characteristics = AnimalCharacteristic.where("animal_id = " + id)
    @animal = Animal.find(params["param"])
    @animal_check = @animal.neutered

    #checking status to display correct one
    @status = StatusType.find(@animal.status_id)
    
    @status_name = @status.name
    #Rails.logger.debug("My object: #{status_name.inspect}")
    
    if (@status_name.to_s == "Intake")

      @intake = Intake.find(@animal.id)
    
      if(@intake.foster_id != nil)
        @intake_foster = User.find(@intake.foster_id).name
        
        @intake_vet = Veterinarian.find(@intake.vet_id).name
        
        @intake_hold = HoldType.find(@intake.intake_hold_id).name
        
        Rails.logger.debug("My object: #{@intake.inspect}")
      end
    end

    if (@status_name.to_s == "Foster")
      @foster = FosterStage.find(@animal.id)
      if(@foster.curr_fost_id != nil)
        @fost_foster = User.find(@foster.curr_fost_id).name
        
        @foster_hold = HoldType.find(@foster.fost_hold_id).name
        
        Rails.logger.debug("My object: #{@foster.inspect}")
      end
    end

    if (@status_name.to_s == "Vetting")
      @test = Vetting.all
      Rails.logger.debug("My object: #{@test.inspect}")
      @vetting = Vetting.find(@animal.id)
      if(@vetting.curr_fost_id != nil)
        @vetting_foster = User.find(@vetting.curr_fost_id).name
        
        @vetting_vet = Veterinarian.find(@vetting.curr_vet_id).name
       
        @vetting_hold = HoldType.find(@vetting.vet_hold_id).name
      end
      #Rails.logger.debug("My object: #{@vetting.inspect}")
    end

    if (@status_name.to_s == "Adopted")
      @adopted = Adopted.find(@animal.id)
      
      #@adopter = Adopter.find(@adopted.adopter_id).name
      
      Rails.logger.debug("My object: #{@adopted.inspect}")
    end

    if (@status_name.to_s == "Sleep")
      @sleep = AniSleep.find(@animal.id)
      
      Rails.logger.debug("My object: #{@sleep.inspect}")
    end
    
    if (@status_name.to_s == "Transfer")
      @transfers = AniTransfer.find(@animal.id)
      
      Rails.logger.debug("My object: #{@transfers.inspect}")
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
    @alerts = []
    @alertsRaw = AnimalAlert.where("animal_id = " + id)
    @alertsRaw.each do |a|

      @alerts.push({
        "id" => a.alert.id,
        "title" => a.alert.title,
        "date" => a.alert.date.to_formatted_s(:long_ordinal),
        "created_by" => a.alert.created_by.name

        })
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

        @comm = params[:intake_cm]
        @hold = params[:intake_hold][:hold_type_id]

        @new_intake = Intake.new({intake_date: @intake, foster_id: @foster,
                      vet_id: @vet, comments: @comm, intake_hold_id: @hold, animal_id: @animal.id})
        @new_intake.save

        Rails.logger.debug("My object: #{@new_intake.inspect}")


      end

      if params["vet_dt"]

        @vetting = params[:vet_dt]
        @foster = params[:vet_fost][:user_id]
        
        @vet = params[:vet_vet][:veterinarian_id]

        @comm = params[:vet_cm]
        @hold = params[:vet_hold][:hold_type_id]

        @new_vet = Vetting.new({vet_date: @vetting, curr_vet_id: @vet, curr_fost_id: @foster, comments: @comm, vet_hold_id: @hold, animal_id: @animal.id})
        @new_vet.save
        
        Rails.logger.debug("My object: #{@new_vet.inspect}")


      end

      if params["foster_dt"]

        @foster_date = params[:foster_dt]
        @foster = params[:fost_fost][:user_id]
 
        @comm = params[:fost_cm]
        @hold = params[:fost_hold][:hold_type_id]

        @new_foster = FosterStage.new({foster_date: @foster_date, curr_fost_id: @foster,
                      comment: @comm, fost_hold_id: @hold, animal_id: @animal.id})
        @new_foster.save

        Rails.logger.debug("My object: #{@new_foster.inspect}")


      end

      if params["sleep_dt"]

        @sleep = params[:sleep_dt]

        @comm = params[:sleep_cm]

        @new_sleep = AniSleep.new({sleep_date: @sleep, comments: @comm, animal_id: @animal.id})
        @new_sleep.save

        Rails.logger.debug("My object: #{@new_sleep.inspect}")


      end

      if params["transfer_dt"]

        @transfer = params[:transfer_dt]

        @comm = params[:transfer_cm]


        @new_transfer = AniTransfer.new({transfer_date: @transfer, comments: @comm, animal_id: @animal.id})

        @new_transfer.save

        Rails.logger.debug("My object: #{@new_transfer.inspect}")


      end
      
      if params["adopted_dt"]

        @adopt_date = params[:adopted_dt]
 
        @comm = params[:adopted_cm]

        @new_adopt = Adopted.new({adopt_date: @adopt_date, comments: @comm, animal_id: @animal.id})
        @new_adopt.save
        Rails.logger.debug("My object: #{@new_adopt.inspect}")


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
    @animals = Animal.all
    arr = []

    @animals.each do |d|
      add = true
      # this should check all cases for name 
      if(params["name"] != "" )
        length = params["name"].length.to_i 
        length = length -1 
        if(params["name"].length > d.name.length)
          add = false
        elsif(params["name"] != d.name[0..length])
          add = false
        end
      end 



      if(add)
        arr.push({
          "id" =>  d.id, 
          "name" => d.name,
          "primary" => d.primary_breed.name,
          "picture" => d.picture,
          "age" => getAge(d.birthday)
        })
      end
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
      :adoption_fee, :animal_type, :birthday, :cage_number, :microchip_number, :tag_number, :neutered,  :notes,

      :intake_document, :owner_surrender_document, :home_check_document, :match_application_document, :adoption_application_document, 
      :adoption_contract_document, :vetting_document, :intake_date, 
      )

  end
end

