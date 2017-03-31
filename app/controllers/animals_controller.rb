class AnimalsController < ApplicationController
  def list
    @animal = Animal.new
    @allAnimals = Animal.all
  end

  def new
    @animal = Animal.new
    @new_intake = Intake.new
    @status = StatusType.all
    @sub_status = SubStatusType.all
    @marketing = MarketingType.all

    @breed = Breed.order('name ASC')
    @behavior = Characteristic.all.order('name ASC')

    #having fosters and adopter display
    @fosters_user = User.where(foster_check: true)
    @foster_non_user = NonUser.where(foster_check: true)
    Rails.logger.debug("wow-------------------------------------------")
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
    @sub_status = SubStatusType.all
    @marketing = MarketingType.all
    
    @breed = Breed.order('name ASC')
    @breeds = AnimalBreed.where("animal_id = " + params["param"])
    @behavior = Characteristic.all.order('name ASC')
    @behaviors =  AnimalCharacteristic.where("animal_id = " + params["param"])
    
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

    #STATUS STUFF--------------- SO MAGIC MUCH WOW SO COMPLICATED

    #INTAKE does any entry exist?
    @if_intake = Intake.where(animal_id: @animal.id).exists?
    
    #This code below edits the first entry in the intake table for that animal
    #this isn't editing anything its just copies the first entry into the edit page to display
    if @if_intake #there is an entry
      
      #@intake = Intake.where(animal_id: @animal.id)
      #@intake = Intake.find_by animal_id: @animal.id
      @intake = Intake.where(animal_id: @animal.id)

      @intake_date = @intake[0].intake_date
      @intake_comm = @intake[0].comments
      #Rails.logger.debug("Edit Intake --------------------: #{@intake.inspect}")
      
      if @intake[0].foster_id != nil
         @foster = Foster.find_by id: @intake[0].foster_id
      #   Rails.logger.debug("Foster --------------------: #{@foster.inspect}")
        
         if @foster.user_id == nil and @foster.non_user_id != nil
           @intake_foster = NonUser.find(@foster.non_user_id).id
         elsif @foster.user_id != nil and @foster.non_user_id == nil
           @intake_foster = User.find(@foster.user_id).id
         end
       end
      
       if @intake[0].sub_status_id != nil
         @intake_subs = SubStatusType.find(@intake[0].sub_status_id).id
      end
       if @intake[0].animal_facility_id != nil
         @intake_prevs = AnimalFacility.find(@intake[0].animal_facility_id).id
         #Rails.logger.debug("Previous --------------------: #{@intake_prevs.inspect}")
       end
       if @intake[0].vet_id != nil
         @intake_vets = Veterinarian.find(@intake[0].vet_id).id
         #Rails.logger.debug("Edit Vrt --------------------: #{@intake_vets.inspect}")
       end
    end
    #----------------------------------------------------------

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
    @status_name = @status.name
    if @animal.sub_status_id != nil
      @sub_status_name = SubStatusType.find(@animal.sub_status_id).name
    end
    
    @behaviors =  AnimalCharacteristic.where("animal_id = " + params["param"])

    @allIntakes = Intake.where(animal_id: @animal.id)
    @allVetting = Vetting.where(animal_id: @animal.id)
    @allTraining = Training.where(animal_id: @animal.id)
    @allAdopt = Adopted.where(animal_id: @animal.id)
    @allFoster = FosterStatus.where(animal_id: @animal.id)
    @allOther = OtherStatus.where(animal_id: @animal.id)
    #@allHistory = @allIntakes + @allVetting + @allTraining + @allAdopt + @allFoster + @allOther

    #so we need this value to pass to intake modal so it knows we are creating a new Intake or whatever status
    @new_intake = Intake.new
    @new_vet = Vetting.new
    @new_train = Training.new
    @new_adopt = Adopted.new
    @new_fost = FosterStatus.new
    @new_other = OtherStatus.new



    #Intake Status----------------
    @intake_stats = []

    if @allIntakes != [] 
      @allIntakes.each do |a|
         @intake_loc = nil
         if a.foster_id != nil
           @foster = Foster.find_by id: a.foster_id
        #   Rails.logger.debug("Foster --------------------: #{@foster.inspect}")
          
           if @foster.user_id == nil and @foster.non_user_id != nil
             @intake_loc = NonUser.find(@foster.non_user_id).name
           elsif @foster.user_id != nil and @foster.non_user_id == nil
             @intake_loc = User.find(@foster.user_id).name
           end
         end
        
         if a.sub_status_id != nil
           @intake_subs = SubStatusType.find(a.sub_status_id).name
        end
         if a.animal_facility_id != nil
           @intake_prevs = AnimalFacility.find(a.animal_facility_id).name
           #Rails.logger.debug("Previous --------------------: #{@intake_prevs.inspect}")
         end
         if a.vet_id != nil
           @intake_loc = Veterinarian.find(a.vet_id).name
           #Rails.logger.debug("Edit Vrt --------------------: #{@intake_vets.inspect}")
         end
        @intake_stats.push({
          "status" => "Intake",
          "id" => a.id,
          "date" => a.intake_date,
          "sub_status" => @intake_subs,
          "location" => @intake_loc,
          "prev_location" => @intake_prevs,
          "comm" => a.comments

          })
      end
    end
    
    if @allFoster != [] 

      @foster_stats = []

      @allFoster.each do |a|
        if a.foster_id != nil
          @foster = Foster.find_by id: a.foster_id    
          if @foster.user_id == nil and @foster.non_user_id != nil
            @fost_foster = NonUser.find(@foster.non_user_id).name
          elsif @foster.user_id != nil and @foster.non_user_id == nil

            @fost_foster = User.find(@foster.user_id).name

          end
        end
      
        if a.homecheck = true
          @fost_home = "Completed"
        else
          @fost_home = "Incomplete"
        end
        if a.vet_id != nil
          @fost_vet = Veterinarian.find(a.vet_id).name
        end
        if a.sub_status_id != nil
          @foster_sub = SubStatusType.find(a.sub_status_id).name
        end
        @foster_stats.push({
          "status" => "Foster",
          "date" => a.foster_date,
          "foster" => @fost_foster,
          "vet" => @fost_vet,
          "homecheck" => @fost_home,
          "sub_status" => @foster_sub,
          "comm" => a.comments
          })
      end
    end

    if @allVetting != [] 
      @vet_stats = []
      
      @allVetting.each do |a|

        if a.curr_vet_id != nil
          @vetting_vet = Veterinarian.find(a.curr_vet_id).name
        end
        if a.sub_status_id != nil
          @vet_sub = SubStatusType.find(a.sub_status_id).name
        end
        
        @vet_stats.push({
          "status" => "Vetting",
          "date" => a.vet_date,
          "vet" => @vetting_vet,
          "sub_status" => @vet_sub,
          "comm" => a.comments

          })
      end
    end

    if @allAdopt != [] 
      @adopt_stats = []
      
      @allAdopt.each do |a|
        if a.adopter_id != nil
          @adopter = Adopter.find_by id: a.adopter_id
          
          if @adopter.user_id == nil and @adopter.non_user_id != nil
            @adopt_adopter = NonUser.find(@adopter.non_user_id).name
          end
          if @adopter.user_id != nil and @adopter.non_user_id == nil
            @adopt_adopter = User.find(@adopter.user_id).name
          end
        end

        if a.sub_status_id != nil
          @adopt_sub = SubStatusType.find(a.sub_status_id).name
        end
        @adopt_stats.push({
            "status" => "Adopted",
            "date" => a.adopt_date,
            "adopt" => @adopt_adopter,
            "sub_status" => @adopt_sub,
            "comm" => a.comments

            })
      end
    end

    if @allTraining != [] 
      @train_stats = []
      
      @allTraining.each do |a|
       
        if a.trainer_id != nil
          @training_trainer = Trainer.find(a.trainer_id).name
          
        end
        if a.sub_status_id != nil
          @train_sub = SubStatusType.find(a.sub_status_id).name
        end
        @train_stats.push({
              "status" => "In Training",
              "date" => a.train_date,
              "train" => @training_trainer,
              "sub_status" => @train_sub,
              "comm" => a.problem_info

              })
      end
    end

    if @allOther != []
      @other_stats = []
      
      @allOther.each do |a|
        if a.status_name != nil
          @other_name = a.status_name
        else
          @other_name = "Other"
        end

        if a.sub_status_id != nil
          @other_sub = SubStatusType.find(@other_status.sub_status_id).name
        end

        @other_stats.push({
                "status" => "Other",
                "date" => a.other_date,
                "sub_status" => @other_sub,
                "comm" => a.comments
                })
      end
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
      #You can edit these entries in Edit Animal

      @status = StatusType.find(@animal.status_id)
      @status_name = @status.name

      @date_made = @animal.created_at.strftime("%m/%d/%Y")
      
      if (params["intake_dt"] == "" or params["intake_dt"] == nil) and @status_name.to_s == "Intake"

        @new_intake = Intake.new({intake_date: @date_made, foster_id: nil,
                      vet_id: nil, comments: nil, animal_id: @animal.id, sub_status_id: @animal.sub_status_id, animal_facility_id: nil})
        @new_intake.save
      end
      
      if (params["vet_dt"] == "" or params["vet_dt"] == nil) and @status_name.to_s == "Vetting"

        @new_vetting = Vetting.new({vet_date: @date_made, curr_vet_id: nil, curr_fost_id: nil, comments: nil, animal_id: @animal.id, sub_status_id: @animal.sub_status_id})
        Rails.logger.debug("Vetting-----------------------: #{@new_vet.inspect}")
        @new_vetting.save
        #Rails.logger.debug("My object: #{@new_vet.inspect}")
      end

      if (params["foster_dt"] == "" or params["foster_dt"] == nil) and @status_name.to_s == "Foster"

        @new_foster = FosterStatus.new({foster_date: @date_made,  foster_id: nil, adopter_id: nil, vet_id: nil, homecheck: nil, comments: nil, sub_status_id: @animal.sub_status_id, animal_id: @animal.id})
        @new_foster.save
        #Rails.logger.debug("My object: #{@new_foster.inspect}")
      end

      if (params["training_dt"] == "" or params["training_dt"] == nil) and @status_name.to_s == "In Training"

        @new_train = Training.new({train_date: @date_made, problem_info: nil, expense: 0, animal_id: @animal.id, trainer_id: nil, sub_status_id: @animal.sub_status_id})

        @new_train.save
        #Rails.logger.debug("My object: #{@new_adopt.inspect}")
      end

      if (params["adopted_dt"] == "" or params["adopted_dt"] == nil) and @status_name.to_s == "Adopted"

        @new_adopt = Adopted.new({adopt_date: @date_made, adopter_id: nil, comments: nil, animal_id: @animal.id, sub_status_id: @animal.sub_status_id})

        @new_adopt.save
        #Rails.logger.debug("My object: #{@new_adopt.inspect}")
      end

      if (params["other_dt"] == ""  or params["other_dt"] == nil) and @status_name.to_s == "Other"

        @new_other = OtherStatus.new({other_date: @date_made, sub_status_id: @animal.sub_status_id, animal_id: @animal.id, comments: nil, status_name: nil})
        @new_other.save
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
      if params["intake_dt"] != "" and params["intake_dt"] != nil
        Rails.logger.debug("Intake --------------------:")
        @intake = params[:intake_dt]
        @foster = params[:intake_fost][:foster_id]
        @vet = params[:intake_vet][:veterinarian_id]

        #Right now will accept both vet and foster as location
        #!!!!!Need to make it so it only picks one
        @test = NonUser.where(email: @foster)
        Rails.logger.debug("NonUser ---------------: #{@test.inspect}")

        if User.where(email: @foster) != []
          @temp = User.where(email: @foster)
          #Rails.logger.debug("email------------: #{@temp.inspect}")
          @intake_foster = Foster.where(user_id: @temp.ids)
          @intake_id = @intake_foster.ids[0]
          #Rails.logger.debug("temp: #{@intake_foster.inspect}")
        end
        if NonUser.where(email: @foster) != []
          @temp = NonUser.where(email: @foster)
          @intake_foster = Foster.where(non_user_id: @temp.ids)
          @intake_id = @intake_foster.ids[0]
        end

        @comm = params[:intake_cm]
        #@intake_sub = @animal.sub_status_id
        @ani_faci = params[:intake_prev][:animal_facility_id]
        @intake_sub = params[:intake_sub][:sub_status_id]

        @new_intake = Intake.new({intake_date: @intake, foster_id: @intake_id,
                      vet_id: @vet, comments: @comm, animal_id: @animal.id, sub_status_id: @intake_sub, animal_facility_id: @ani_faci})
        @new_intake.save

        #Rails.logger.debug("New Intake: #{@new_intake.inspect}")


      end
      #VETTING -----------------------------------
      if params["vet_dt"] != "" and params["vet_dt"] != nil

        @vetting = params[:vet_dt]

        #Leave this for now
        #@foster = params[:vet_fost][:user_id]
        @foster = nil
        @vet = params[:vet_vet][:veterinarian_id]

        @comm = params[:vet_cm]
        @vet_sub = params[:vet_sub][:sub_status_id]

        @new_vetting = Vetting.new({vet_date: @vetting, curr_vet_id: @vet, curr_fost_id: @foster, comments: @comm, animal_id: @animal.id, sub_status_id: @vet_sub})
        #Rails.logger.debug("Vetting--------------: #{@new_vet.inspect}")
        @new_vetting.save
        
      end

      #FOSTER ---------------------------------
      if params["foster_dt"] != "" and params["foster_dt"] != nil

        @foster_date = params[:foster_dt]
        
        @foster = params[:fost_fost][:foster_id]
        @vet = params[:fost_vet][:veterinarian_id]
        
        @homecheck = params[:foster_check]
        @fost_sub  = params[:fost_sub][:sub_status_id]

        if @homecheck == "1"
          @fost_home = true
        else
          @fost_home = false
        end

        if User.where(email: @foster) != []
          @temp = User.where(email: @foster)
          @fost_foster = Foster.where(user_id: @temp.ids)
          @foster_id = @fost_foster.ids[0]
          #Rails.logger.debug("temp: #{@fost_foster.inspect}")
        end
        if NonUser.where(email: @foster) != []
          @temp = NonUser.where(email: @foster)
          @fost_foster = Foster.where(non_user_id: @temp.ids)
          #Rails.logger.debug("temp: --------------#{@fost_foster.inspect}")
          @foster_id = @fost_foster.ids[0]
          #Rails.logger.debug("id: --------------#{@foster_id.inspect}")
        end
 

        @comm = params[:fost_cm]
        
        @new_foster = FosterStatus.new({foster_date: @foster_date,  foster_id: @foster_id, adopter_id: nil, vet_id: nil, homecheck: @fost_home, comments: @comm, sub_status_id: @fost_sub, animal_id: @animal.id})
        @new_foster.save
        #Rails.logger.debug("My new foster -----------: #{@new_foster.inspect}")


      end

      #TRAINING --------------------------------
      if params["training_dt"] != "" and params["training_dt"] != nil

        @train_date = params[:training_dt]
        @trainer = params[:trainer_train][:trainer_id]

        @problem_info = params[:training_cm]
        
        @train_sub  = params[:training_sub][:sub_status_id]

        @new_train = Training.new({train_date: @train_date, problem_info: @problem_info, expense: 0, animal_id: @animal.id, trainer_id: @trainer, sub_status_id: @train_sub})

        @new_train.save
        #Rails.logger.debug("My object: #{@new_adopt.inspect}")

      end

      #ADOPTED --------------------------------
      if params["adopted_dt"] != "" and params["adopted_dt"] != nil
        #Rails.logger.debug("Adopt------------------: #{params["adopted_dt"].inspect}")
        @adopt_date = params[:adopted_dt]
        @adopt_sub = params[:adopt_sub][:sub_status_id]
        @adopter = params[:adopt_adopter][:adopter_id]

        if User.where(email: @adopter) != []
          @temp = User.where(email: @adopter)
          @adopt_adopter = Adopter.where(user_id: @temp.ids)
          @adopt_id = @adopt_adopter.ids[0]
        end

        if NonUser.where(email: @adopter) != []
          @temp = NonUser.where(email: @adopter)
          @adopt_adopter = Adopter.where(non_user_id: @temp.ids)
          @adopt_id = @adopt_adopter.ids[0]
        end

        @comm = params[:adopted_cm]

        @new_adopt = Adopted.new({adopt_date: @adopt_date, adopter_id: @adopt_id, comments: @comm, animal_id: @animal.id, sub_status_id: @adopt_sub})

        @new_adopt.save
        #Rails.logger.debug("My final obj: #{@adopter_adopt.ids.inspect}")
      end

      #OTHER -----------------------------------------
      if params["other_dt"] != "" and params["other_dt"] != nil

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
    
      #INTAKE -----------------------------
    #grabs all the intake entries to compare 
    @intake = Intake.where(animal_id: @animal.id)

    #Rails.logger.debug("Edit animal ---------------: #{@intake[0].id.inspect}")
    
    #checking if any of of the intake params changed, if they did update
    if params[:intake_dt] != @intake[0].intake_date or params[:intake_fost][:foster_id] != @intake[0].foster_id or params[:intake_vet][:veterinarian_id] != @intake[0].vet_id or
      params[:intake_cm] != @intake[0].comments or params[:intake_prev][:animal_facility_id] !=
      @intake[0].animal_facility_id or params[:intake_sub][:sub_status_id] != @intake[0].sub_status_id


      @intake_dates = params[:intake_dt]
      @foster = params[:intake_fost][:foster_id]
      @vet = params[:intake_vet][:veterinarian_id]
      #Rails.logger.debug("Vet ID---------------: #{@vet.inspect}")

      #Right now will accept both vet and foster as location
      #!!!!!Need to make it so it only picks one
      #@test = NonUser.where(email: @foster)
      #Rails.logger.debug("NonUser ---------------: #{@test.inspect}")

      if User.where(email: @foster) != []
        @temp = User.where(email: @foster)
        #Rails.logger.debug("email------------: #{@temp.inspect}")
        @intake_foster = Foster.where(user_id: @temp.ids)
        @intake_id = @intake_foster.ids[0]
        #Rails.logger.debug("temp: #{@intake_foster.inspect}")
      end
      if NonUser.where(email: @foster) != []
        @temp = NonUser.where(email: @foster)
        @intake_foster = Foster.where(non_user_id: @temp.ids)
        @intake_id = @intake_foster.ids[0]
      end

      @comm = params[:intake_cm]
      #@intake_subs = @animal.sub_status_id
      @ani_faci = params[:intake_prev][:animal_facility_id]
      @intake_subs = params[:intake_sub][:sub_status_id]


      @new_intake = Intake.find_by id: @intake[0].id
      #Rails.logger.debug("Intake ID---------------: #{@new_intake.inspect}")
      
      @new_intake.intake_date = @intake_dates
      @new_intake.foster_id = @intake_id
      @new_intake.vet_id = @vet
      @new_intake.comments = @comm
      #@new_intake.animal_id = @animal.id
      @new_intake.sub_status_id = @intake_subs
      @new_intake.animal_facility_id = @ani_faci
      
      @new_intake.save

      #Rails.logger.debug("New Intake: #{@new_intake.inspect}")

    end

    #checks if there were any updates to the animal object
    if @animal.update_attributes(animal_params)
       AnimalBreed.where("animal_id = " + @animal.id.to_s).delete_all
       AnimalCharacteristic.where("animal_id = " + @animal.id.to_s).delete_all
       
       if params["intake_dt_modal"] != "" and params["intake_dt_modal"] != nil
        Rails.logger.debug("Intake --------------------:")
        @intake = params[:intake_dt_modal]
        @foster = params[:intake_fost_modal][:foster_id]
        @vet = params[:intake_vet_modal][:veterinarian_id]

        #Right now will accept both vet and foster as location
        #!!!!!Need to make it so it only picks one
        @test = NonUser.where(email: @foster)
        #Rails.logger.debug("NonUser ---------------: #{@test.inspect}")

        if User.where(email: @foster) != []
          @temp = User.where(email: @foster)
          #Rails.logger.debug("email------------: #{@temp.inspect}")
          @intake_foster = Foster.where(user_id: @temp.ids)
          @intake_id = @intake_foster.ids[0]
          #Rails.logger.debug("temp: #{@intake_foster.inspect}")
        end
        if NonUser.where(email: @foster) != []
          @temp = NonUser.where(email: @foster)
          @intake_foster = Foster.where(non_user_id: @temp.ids)
          @intake_id = @intake_foster.ids[0]
        end

        @comm = params[:intake_cm_modal]
        #@intake_sub = @animal.sub_status_id
        @ani_faci = params[:intake_prev_modal][:animal_facility_id]
        @intake_sub = params[:intake_sub_modal][:sub_status_id]

        @new_intake = Intake.new({intake_date: @intake, foster_id: @intake_id,
                      vet_id: @vet, comments: @comm, animal_id: @animal.id, sub_status_id: @intake_sub, animal_facility_id: @ani_faci})
        @new_intake.save

        @allIntakes = Intake.all
        #Rails.logger.debug("Modal Add: #{@allIntakes.inspect}")
      end

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
      :adoption_contract_document, :vetting_document, :sub_status_id, :marketing_id
      )

  end
end

