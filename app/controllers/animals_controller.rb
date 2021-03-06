class AnimalsController < ApplicationController
  before_filter :check_for_mobile
  def list
    @animal = Animal.new
    @allAnimals = Animal.all
    @breeds = Breed.where("name != 'Mixed'").order('name ASC')
    @statuses = StatusType.all
    @ageMin = params["?a"]
    @ageMax = params["?A"]
    @active = params["?Act"]
    @inactive = params["?Inact"]
    
    if(@ageMin == nil ) 
      @ageMin = 0
    end
    if(@ageMax == nil ) 
      @ageMax = 15
    end

    @name = params["n"]
    @gender = params["?g"]
    @breed = params["?b"]
    @status = params["?s"]
    
  end

  def destroy
    id = params["id"]
    
    @animals = Animal.destroy(id)
    @ani_alerts = AnimalAlert.where(animal_id: id).delete_all
    @alerts = Alert.where(animal_id: id).delete_all
    @intake = Intake.where(animal_id: id).delete_all
    @vetting = Vetting.where(animal_id: id).delete_all
    @foster = FosterStatus.where(animal_id: id).delete_all
    @train = Training.where(animal_id: id).delete_all
    @adopt = Adopted.where(animal_id: id).delete_all
    @apps = AnimalApplication.where(animal_id: id).delete_all
    @breeds = AnimalBreed.where(animal_id: id).delete_all
    @ani_charac = AnimalCharacteristic.where(animal_id: id).delete_all

    flash.now[:success] = "Deleted Animal!"
    redirect_to :controller => "animals", :action => "list", :param => @animals
  end
  
  def new
    @animal = Animal.new
    @new_intake = Intake.new
    @status = StatusType.all.order('name ASC')

    @sub_status = SubStatusType.all.order('name ASC')
    @marketing = MarketingType.all.order('name ASC')
    @intake_reason = IntakeReason.all.order('name ASC')

    @breed = Breed.order('name ASC')
    @behavior = Characteristic.all.order('name ASC')

    @primary = []
    @secondary = []
    @mixed = Breed.where("name = 'Mixed'")

    @secondary.push(@mixed[0])
    @breed.each do |b|
      @primary.push(b)
      @secondary.push(b)
    end

    #We need to get a list of all the users who are coordinators or administrators
    @coord_id = Role.find_by title: "Coordinator"
    @admin_id = Role.find_by title: "Administrator"

    @coordinators = User.where("role_id = ? OR role_id = ?", @coord_id.id, @admin_id.id )

    #having fosters and adopter display
    @fosters_user = User.where(foster_check: true)
    @foster_non_user = NonUser.where(foster_check: true)
    @fosters = @fosters_user + @foster_non_user
    
    @adopt_user = User.where(adopt_check: true)
    @adopt_non_user = NonUser.where(adopt_check: true)
    @adopters = @adopt_user + @adopt_non_user


  end
  
  def profile
    id = params["param"]
    @animal = Animal.find(id) 
    @behaviors =  AnimalCharacteristic.where("animal_id = " + params["param"])
    @status_type = StatusType.all
    @sub_status = SubStatusType.all.order('name ASC')
    @behavior = Characteristic.where("category = 'Behavior'")
    @marketing = MarketingType.all.order('name ASC')
    @breed = Breed.where("name != 'Mixed'").order('name ASC')
    @mixed = Breed.where("name = 'Mixed'")

    @primary = []
    @secondary = []
    @secondary.push(@mixed[0])
    @breed.each do |b|
      @primary.push(b)
      @secondary.push(b)
    end

    @coord_id = Role.find_by title: "Coordinator"
    @admin_id = Role.find_by title: "Administrator"
    #Rails.logger.debug("My admin--------------: #{@admin_id.inspect}")

    @coordinators = User.where(role_id: @coord_id.id, role_id: @admin_id.id)

    @breeds = AnimalBreed.where("animal_id = " + id)
    @characteristics = AnimalCharacteristic.where("animal_id = " + id)
    @animal = Animal.find(params["param"])
    @animal_check = @animal.neutered

    #checking status to display correct one
    @status = StatusType.find(@animal.status_id)
    #having fosters and adopter display
    @fosters_user = User.where(foster_check: true)
    @foster_non_user = NonUser.where(foster_check: true)

    @fosters = @fosters_user + @foster_non_user

    @adopt_user = User.where(adopt_check: true)
    @adopt_non_user = NonUser.where(adopt_check: true)
    @adopters = @adopt_user + @adopt_non_user
    # -----------------------------------
    @status_name = @status.name

    #animal.inactive_animal is true animal should be filtered out
    #else if false display on the animal list  page
    #Rails.logger.debug("Hidden tester: #{@animal.inactive_animal.inspect}")
    
    if @animal.inactive_animal?
      @hidden = "Hidden"
    else
      @hidden = "Visible"
    end

    if @animal.vetting_completed?
      @vet_done = "Complete"
    else
      @vet_done = "Incomplete"
    end

    if @animal.sub_status_id != nil
      @sub_status_name = SubStatusType.find(@animal.sub_status_id).name
    end
    
    @behavior = Characteristic.all.order('name ASC')
    @behaviors =  AnimalCharacteristic.where("animal_id = " + params["param"])

    @allIntakes = Intake.where(animal_id: @animal.id).order('intake_date DESC')
    @allVetting = Vetting.where(animal_id: @animal.id).order('vet_date DESC')
    @allTraining = Training.where(animal_id: @animal.id).order('train_date DESC')
    @allAdopt = Adopted.where(animal_id: @animal.id).order('adopt_date DESC')
    @allFoster = FosterStatus.where(animal_id: @animal.id).order('foster_date DESC')
    @allApps = AnimalApplication.where(animal_id: @animal.id).order('app_date DESC')

    #so we need this value to pass to intake modal so it knows we are creating a new Intake or whatever status
    @new_intake = Intake.new
    @new_vet = Vetting.new
    @new_train = Training.new
    @new_adopt = Adopted.new
    @new_fost = FosterStatus.new
    @new_app = AnimalApplication.new
    
    @app_stats = []
    if @allApps != [] 
      
      
      @allApps.each do |a|
        if a.adopter_id != nil
          @adopter = Adopter.find_by id: a.adopter_id
          
          if @adopter.user_id == nil and @adopter.non_user_id != nil
            @adopt_adopt = NonUser.find(@adopter.non_user_id).name
            @adopt_email = NonUser.find(@adopter.non_user_id).email
          end
          if @adopter.user_id != nil and @adopter.non_user_id == nil
            @adopt_adopt = User.find(@adopter.user_id).name
            @adopt_email = User.find(@adopter.user_id).email
          end
        end

        @app_stats.push({
            "email" => @adopt_email,
            "id" => a.id,
            "date" => a.app_date,
            "adopt" => @adopt_adopt,
            "comm" => a.comments,
            "text_app" => a.text_app
            })
      end
    end

    #Intake Status----------------
    @intake_stats = []

    if @allIntakes != [] 
      @allIntakes.each do |a|
         @intake_loc = nil
        
         if a.sub_status_id != nil
           @intake_subs = SubStatusType.find(a.sub_status_id).name
        end
         if a.animal_facility_id != nil
           @intake_prevs = AnimalFacility.find(a.animal_facility_id).name
           #Rails.logger.debug("Previous --------------------: #{@intake_prevs.inspect}")
         end
        
        @intake_stats.push({
          "status" => "Intake",
          "id" => a.id,
          "email" => @intake_email,
          "date" => a.intake_date,
          "sub_status" => @intake_subs,
          "location" => @intake_prevs,
          "prev_location" => @intake_prevs,
          "comm" => a.comments

          })
      end
      #Rails.logger.debug("Status Array --------------------: #{@intake_stats.inspect}")
      #Rails.logger.debug("Intake Status Array --------------------: #{@allIntakes.inspect}")
    end
    @foster_stats = []
    if @allFoster != []    

      @allFoster.each do |a|
        if a.foster_id != nil
          @foster = Foster.find_by id: a.foster_id    
          if @foster.user_id == nil and @foster.non_user_id != nil
            @fost_foster = NonUser.find(@foster.non_user_id).name
            @fost_email = NonUser.find(@foster.non_user_id).email
          elsif @foster.user_id != nil and @foster.non_user_id == nil
            @fost_foster = User.find(@foster.user_id).name
            @fost_email = User.find(@foster.user_id).email

          end
        end
      
        if a.sub_status_id != nil
          @foster_sub = SubStatusType.find(a.sub_status_id).name
        end
        
        @foster_stats.push({
          "status" => "Foster",
          "id" => a.id,
          "date" => a.foster_date,
          "foster" => @fost_foster,
          "sub_status" => @foster_sub,
          "comm" => a.comments
          })
      end
    end
    @vet_stats = []
    if @allVetting != [] 
      
      
      @allVetting.each do |a|

        if a.curr_vet_id != nil
          @vetting_vet = Veterinarian.find(a.curr_vet_id).name
        end
        if a.sub_status_id != nil
          @vet_sub = SubStatusType.find(a.sub_status_id).name
        end
        
        @vet_stats.push({
          "status" => "Vetting",
          "id" => a.id,
          "date" => a.vet_date,
          "vet" => @vetting_vet,
          "sub_status" => @vet_sub,
          "comm" => a.comments

          })
      end
    end
    @adopt_stats = []
    if @allAdopt != [] 
      
      
      @allAdopt.each do |a|
        if a.adopter_id != nil
          @adopter = Adopter.find_by id: a.adopter_id
          
          if @adopter.user_id == nil and @adopter.non_user_id != nil
            @adopt_adopt = NonUser.find(@adopter.non_user_id).name
            @adopt_email = NonUser.find(@adopter.non_user_id).email
          end
          if @adopter.user_id != nil and @adopter.non_user_id == nil
            @adopt_adopt = User.find(@adopter.user_id).name
            @adopt_email = User.find(@adopter.user_id).email
          end
        end

        if a.sub_status_id != nil
          @adopt_sub = SubStatusType.find(a.sub_status_id).name
        end
        @adopt_stats.push({
            "status" => "Adopted",
            "email" => @adopt_email,
            "id" => a.id,
            "date" => a.adopt_date,
            "adopt" => @adopt_adopt,
            "sub_status" => @adopt_sub,
            "comm" => a.comments

            })
      end
    end
    @train_stats = []
    if @allTraining != [] 
      
      
      @allTraining.each do |a|
       
        if a.trainer_id != nil
          @training_trainer = Trainer.find(a.trainer_id).name
          
        end
        if a.sub_status_id != nil
          @train_sub = SubStatusType.find(a.sub_status_id).name
        end
        @train_stats.push({
              "status" => "In Training",
              "id" => a.id,
              "date" => a.train_date,
              "train" => @training_trainer,
              "sub_status" => @train_sub,
              "comm" => a.problem_info

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

    if params["prim_breeds"]
      @animal.primary_breed = Breed.find(params["prim_breeds"].to_i)
    end
    Rails.logger.debug("Params--------------: #{params.inspect}")
    if @animal.save

      @status = StatusType.find(@animal.status_id)
      @status_name = @status.name

      @date_made = @animal.created_at.strftime("%m/%d/%Y")
      
      if (params["intake_dt"] == "" or params["intake_dt"] == nil) and @status_name.to_s == "Intake"

        @new_intake = Intake.new({intake_date: @date_made, comments: nil, animal_id: @animal.id, sub_status_id: @animal.sub_status_id, animal_facility_id: nil, intake_reason_id: nil, current_entry: true})
        @new_intake.save
      end
      
      #INTAKE -----------------------------
      if params["intake_dt"] != "" and params["intake_dt"] != nil
        @intake = params[:intake_dt]

        @intake_loc = params[:intake_loc][:intake_reason_id]

        @comm = params[:intake_cm]
        @ani_faci = params[:intake_prev][:animal_facility_id]
        @intake_sub = params[:intake_sub][:sub_status_id]

        @new_intake = Intake.new({intake_date: @intake, comments: @comm, animal_id: @animal.id, sub_status_id: @intake_sub, animal_facility_id: @ani_faci, intake_reason_id: @intake_loc, current_entry: true})
        @new_intake.save

      end

      if params["behavior"]
        arr = params["behavior"].split("|")
        arr.each do |d|
          
        @Characteristic = AnimalCharacteristic.new({animal_id: @animal.id, characteristic_id: d})
        @Characteristic.save
        end
      end

      if params["breeds"]
        arr = params["breeds"].split("|")
        arr.each do |d|
          
        @breed = AnimalBreed.new({animal_id: @animal.id, breed_id: d})
        @breed.save
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
      redirect_to :controller => "animals", :action => "new"
    end
  end
  skip_before_filter :verify_authenticity_token, :only => :editAnimal
  
  
  def editAnimal
    @animal = Animal.find(params[:animal_id])
    #checks if there were any updates to the animal object
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

  def querySimple 
    @animals = Animal.all
    arr = []
    @animals.each do |d|
      arr.push({
          "id" =>  d.id, 
          "name" => d.name,
          "primary" => d.primary_breed.name,
          "gender" => d.gender,
          "status" => d.status.name,
          "picture" => d.picture,
          "age" => getAge(d.birthday)
        })
    end
    render json: arr
  end

  def querySimpleStatus
    @animals = Animal.all
    @status = StatusType.all
    
    arr = []

    @status.each do |d|
      @count = @animals.select {|a| a.status_id == d.id}.count
      arr.push({
          "id" =>  d.id, 
          "name" => d.name,
          "count" => @count,
        })
    end
    render json: arr
  end

  def querySimpleCoor
    @animals = Animal.where(coordinator_id: current_user.id)
    
    arr = []

    @animals.each do |d|
      arr.push({
          "id" =>  d.id, 
          "name" => d.name,
          "primary" => d.primary_breed.name,
          "gender" => d.gender,
          "age" => d.age(),
          "status" => d.status.name,
        })
    end
    render json: arr
  end

  def query
    
    @animals = Animal.all
    arr = []
    
    @animals.each_with_index do |d, index|
      add = true
      # this should check all cases for name 
      if(params["name"] != "" && params["name"] != " " )
        length = params["name"].length.to_i 
        length = length -1 
        if(params["name"].length > d.name.length)
          add = false
        elsif(params["name"].downcase != d.name[0..length].downcase)
          add = false
        end
      end 

      if(params["breed"] != "")
        if(params["breed"].to_i != d.primary_breed_id)
          add = false
        end
      end

      if(params["gender"] != "")
        if(params["gender"] != d.gender)
          add = false
        end
      end

      if(params["status"] != "")
        if(params["status"].to_i != d.status_id)
          add = false
        end
      end

      # if(params["neutered"] != "")
      #   if(params["neutered"] != d.neutered)
      #     add = false
      #   end
      # end

      if(params["age_min"] != ""  && params["age_max"] != "")

        ageMin = params["age_min"].to_i
        ageMax = params["age_max"].to_i
        age = getAge(d.birthday)
        
        if(age < ageMin || age > ageMax)
          add = false
        
        end
      end 

      if(params["active"] != ""  && params["inactive"] != "")

        tmp1 = false
        tmp2 = false
        
        if(d.inactive_animal.to_s == "false" && params["active"] == true.to_s)
          tmp1 = true
        end
        if(d.inactive_animal.to_s == "true" && params["inactive"] == true.to_s)
          tmp2 = true
        end
        if(!tmp1 && !tmp2)
         add = false
        end


      end 

      if(add)
        
        arr.push({
          "id" => d.id,
          "#" =>  index, 
          "name" => d.name,
          "primary" => d.primary_breed.name,
          "gender" => d.gender,
          "status" => d.status.name,
          "picture" => d.picture,
          "age" => d.age(),
          "birthday" => d.birthday.to_formatted_s(:long_ordinal),
          "location" =>d.location(),
          "sub_status" =>d.substatus(),
          "marketing" => d.marketing.name,
          "neutered" => d.neutered,
          "adoption_fee" => d.adoption_fee,
          "notes" => d.notes,
          "coordinator" => d.coordinator.name,
          "active" => !d.inactive_animal
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
      @nonuser = NonUser.where('LOWER(name) LIKE LOWER(:search)' , search: "%#{@search}%")

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
          "gender" => d.gender,
          "status" => d.status.name,
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

    if (!@nonuser.nil?) 
      @nonuser.each do |d|
        arr.push({
          "check" => "nonuser",
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

    params.require(:animal).permit(:name, :primary_breed_id, :secondary_breed_id, :picture, :status_id, :gender, :color_primary, :color_secondary, :eye_color,
      :adoption_fee, :animal_type, :birthday, :cage_number, :microchip_number, :tag_number, :neutered,  :notes,

      :intake_document, :owner_surrender_document, :home_check_document, :match_application_document, :adoption_application_document, 
      :adoption_contract_document, :vetting_document, :sub_status_id, :marketing_id, :inactive_animal, :coordinator_id, :input_date, :date_death, :date_adopted, :vetting_completed

      )

  end
end

