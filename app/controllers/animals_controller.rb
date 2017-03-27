class AnimalsController < ApplicationController
  def list
    @animal = Animal.new
    @allAnimals = Animal.all
  end

  def new
    @animal = Animal.new
    
    @status = StatusType.all
    @sub_status = SubStatusType.all
    @marketing = MarketingType.all
    @breed = Breed.order('name ASC')
    @behavior = Characteristic.all.order('name ASC')

    #having fosters and adopter display
    @fosters_user = User.where(foster_check: true)
    @foster_non_user = NonUser.where(foster_check: true)
    #Rails.logger.debug("My object: #{foster_non_user.inspect}")
    @fosters = @fosters_user + @foster_non_user
    #Rails.logger.debug("My object: #{@fosters.inspect}")
    @adopt_user = User.where(adopt_check: true)
    @adopt_non_user = NonUser.where(adopt_check: true)
    @adopters = @adopt_user + @adopt_non_user
    # -----------------------------------

  end

  def edit
    @animal = Animal.find(params["param"])
    @status = StatusType.all
    @breed = Breed.order('name ASC')
    @breeds = AnimalBreed.where("animal_id = " + params["param"])
    @behavior = Characteristic.all.order('name ASC')



    @behaviors =  AnimalCharacteristic.where("animal_id = " + params["param"])
    


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
    @behaviors =  AnimalCharacteristic.where("animal_id = " + params["param"])

    #Rails.logger.debug("My object: #{status_name.inspect}")
    
    if (@status_name.to_s == "Intake")
      @test = Intake.all
      #Rails.logger.debug("My object: #{@test.inspect}")
      @intake = Intake.find_by animal_id: @animal.id
      
      if @intake.foster_id != nil
        @foster = Foster.find_by id: @intake.foster_id
        Rails.logger.debug("Foster --------------------: #{@foster.inspect}")
        
        if @foster.user_id == nil and @foster.non_user_id != nil
          @intake_foster = NonUser.find(@foster.non_user_id).name
        elsif @foster.user_id != nil and @foster.non_user_id == nil
          @intake_foster = User.find(@foster.user_id).name
        end
      end
      
      if @intake.sub_status_id != nil
        @intake_sub = SubStatusType.find(@intake.sub_status_id).name
      end
      if @intake.vet_id != nil
        @intake_vet = Veterinarian.find(@intake.vet_id).name
      end

    end

    if (@status_name.to_s == "Foster")
      @foster_status = FosterStatus.find_by animal_id: @animal.id
      
      if @foster_status.foster_id != nil
        @foster = Foster.find_by id: @foster_status.foster_id
        Rails.logger.debug("Foster --------------------: #{@foster.inspect}")
        
        if @foster.user_id == nil and @foster.non_user_id != nil
          @intake_foster = NonUser.find(@foster.non_user_id).name
        elsif @foster.user_id != nil and @foster.non_user_id == nil
          @intake_foster = User.find(@foster.user_id).name
        end
      end
      
      if @foster_status.homecheck = true
        @fost_home = "Completed"
      else
        @fost_home = "Incomplete"
      end

      @fost_vet = Veterinarian.find(@foster_status.vet_id).name
      @foster_sub = SubStatusType.find(@foster_status.sub_status_id).name
        
      #Rails.logger.debug("My object: #{@foster.inspect}")
    end

    if (@status_name.to_s == "Vetting")
      @test = Vetting.all
      #Rails.logger.debug("My object: #{@test.inspect}")
      
      @vetting = Vetting.find_by animal_id: @animal.id
      
      if(@vetting.curr_fost_id != nil)
        @vetting_foster = User.find(@vetting.curr_fost_id).name
        
        @vetting_vet = Veterinarian.find(@vetting.curr_vet_id).name
      end
      #Rails.logger.debug("My object: #{@vetting.inspect}")
    end

    if (@status_name.to_s == "Adopted")
      @adopted = Adopted.find_by animal_id: @animal.id
      
      #@adopter = Adopter.find(@adopted.adopter_id).name
      
      #Rails.logger.debug("My object: #{@adopted.inspect}")
    end

    if (@status_name.to_s == "Training")
      @sleep = Training.find_by animal_id: @animal.id
      
      Rails.logger.debug("My object: #{@sleep.inspect}")
    end

    if (@status_name.to_s == "Other")
      @sleep = Other.find_by animal_id: @animal.id
      
      #Rails.logger.debug("My object: #{@sleep.inspect}")
    end
    
    @breeds = AnimalBreed.where("animal_id = " + params["param"])
    @characteristics = AnimalCharacteristic.where("animal_id = " + params["param"])
    

    
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
    @sub_status = SubStatusType.all
    @marketing = Marketing.all

    @allAnimals = Animal.all
    @breed = Breed.all
    @users = User.all

    
    if @animal.save
      #if they only select current status but don't make an entry in the tabs
      @status = StatusType.find(@animal.status_id)
      @status_name = @status.name

      @date_made = @animal.created_at.strftime("%m/%d/%Y")
      @test = params["intake_dt"]
      Rails.logger.debug("Here here--------------------: #{@date_made.inspect}")
      Rails.logger.debug("Param here--------------------: #{@test.inspect}")
      
      if params["intake_dt"] == "" and @status_name.to_s == "Intake"

        @new_intake = Intake.new({intake_date: @date_made, foster_id: nil,
                      vet_id: nil, comments: nil, animal_id: @animal.id, sub_status_id: @animal.sub_status_id, animal_facility_id: nil})
        @new_intake.save
          
        #Rails.logger.debug("My object: #{@intake.inspect}")
      end

      #---------------------------------------
      if params["breeds"]
        arr = params["breeds"].split("|")
        arr.each do |d|
          
        @breed = AnimalBreed.new({animal_id: @animal.id, breed_id: d})
        @breed.save
        end
      end


      #INTAKE -----------------------------
      if params["intake_dt"] != ""
        Rails.logger.debug("Intake --------------------:")
        @intake = params[:intake_dt]
        @foster = params[:intake_fost][:foster_id]
        @vet = params[:intake_vet][:veterinarian_id]

        #Right now will accept both vet and foster as location
        #!!!!!Need to make it so it only picks one
        if User.where(email: @foster) != nil
          @temp = User.where(email: @foster)
          Rails.logger.debug("email------------: #{@temp.inspect}")
          @intake_foster = Foster.where(user_id: @temp.ids)
          #Rails.logger.debug("temp: #{@intake_foster.inspect}")
        elsif NonUser.where(email: @foster) != nil
          @temp = NonUser.where(email: @foster)
          @intake_foster = Foster.where(non_user_id: @temp.ids)
        end

        @comm = params[:intake_cm]
        @intake_sub = @animal.sub_status_id
        @ani_faci = params[:intake_prev][:animal_facility_id]
        @intake_sub = params[:intake_sub][:sub_status_id]

        @new_intake = Intake.new({intake_date: @intake, foster_id: @intake_foster.ids[0],
                      vet_id: @vet, comments: @comm, animal_id: @animal.id, sub_status_id: @intake_sub, animal_facility_id: @ani_faci})
        @new_intake.save

        Rails.logger.debug("New Intake: #{@new_intake.inspect}")


      end
      #VETTING -----------------------------------
      if params["vet_dt"] != ""

        @vetting = params[:vet_dt]

        #Leave this for now
        #@foster = params[:vet_fost][:user_id]
        @foster = nil
        @vet = params[:vet_vet][:veterinarian_id]

        @comm = params[:vet_cm]
        @vet_sub = params[:vet_sub][:sub_status_id]

        @new_vettting = Vetting.new({vet_date: @vetting, curr_vet_id: @vet, curr_fost_id: @foster, comments: @comm, animal_id: @animal.id, sub_status_id: @vet_sub })
        #Rails.logger.debug("My object: #{@new_vet.inspect}")


      end
      #FOSTER ---------------------------------
      if params["foster_dt"] != ""

        @foster_date = params[:foster_dt]
        
        @foster = params[:fost_fost][:foster_id]
        @vet = params[:fost_vet][:veterinarian_id]
        
        @homecheck = params[:foster_check]
        @fost_sub  = params[:fost_sub][:sub_status_id]

        if @homecheck = "1"
          @fost_home = true
        else
          @fost_home = false
        end

        #!!!!!Need to make it so it only picks one
        @fost_foster = nil
        if User.where(email: @foster) != nil
          @temp = User.where(email: @foster)
          #Rails.logger.debug("temp: #{@temp.inspect}")
          @fost_foster = Foster.where(user_id: @temp.ids)
          #Rails.logger.debug("temp: #{@fost_foster.inspect}")
        elsif NonUser.where(email: @foster) != nil
          @temp = NonUser.where(email: @foster)
          @fost_foster = Foster.where(non_user_id: @temp.ids)
        end
 

        @comm = params[:fost_cm]
        
        @new_foster = FosterStatus.new({foster_date: @foster_date,  foster_id: @fost_foster.ids[0], adopter_id: nil, vet_id: nil, homecheck: @fost_home, comments: @comm, sub_status_id: @fost_sub, animal_id: @animal.id})
        @new_foster.save
        #Rails.logger.debug("My object: #{@new_foster.inspect}")


      end

      #TRAINING --------------------------------
      if params["training_dt"] != ""

        @train_date = params[:training_dt]
        @trainer = params[:trainer_train][:trainer_id]

        @problem_info = params[:training_cm]
        
        @train_sub  = params[:training_sub][:sub_status_id]

        @new_train = Training.new({train_date: @train_date, problem_info: @problem_info, expense: 0, animal_id: @animal.id, trainer_id: @trainer, sub_status_id: @train_sub})

        @new_train.save
        #Rails.logger.debug("My object: #{@new_adopt.inspect}")

      end

      #ADOPTED --------------------------------
      if params["adopted_dt"] != ""

        @adopt_date = params[:adopted_dt]
        @adopt_sub = params[:adopt_sub][:sub_status_id]
        @adopter = params[:adopt_adopter][:adopter_id]

        @adopt_adopter = nil

        if User.where(email: @adopter) != nil
          @temp = User.where(email: @adopter)
          @adopter_adopt = Adopter.where(user_id: @temp.ids)
        elsif NonUser.where(email: @adopter) != nil
          @temp = NonUser.where(email: @adopter)
          @adopter_adopt = Adopter.where(non_user_id: @temp.ids)
        end

        @comm = params[:adopted_cm]

        @new_adopt = Adopted.new({adopt_date: @adopt_date, adopter_id: @adopter_adopt, comments: @comm, animal_id: @animal.id, sub_status_id: @adopt_sub})

        @new_adopt.save
        #Rails.logger.debug("My object: #{@new_adopt.inspect}")


      end
      #OTHER -----------------------------------------
      if params["other_dt"] != ""

        @other_date = params[:other_dt]
 
        @other_name = params[:other_nm]

        @other_sub = params[:other_sub][:sub_status_id]

        @other_comm = params[:other_cm]

        @new_other = OtherStatus.new({other_date: @other_date, sub_status_id: @other_sub, animal_id: @animal.id, comments: @other_comm, status_name: @other_name})

        @new_other.save
        #Rails.logger.debug("My object: #{@new_adopt.inspect}")


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

