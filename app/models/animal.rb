class Animal < ActiveRecord::Base

    validates :name, presence: true
    validates :primary_breed, presence: true
    validates :status, presence: true
    
    mount_uploader :picture, AnimalPictureUploader

    mount_uploader :intake_document, FileUploader
    mount_uploader :owner_surrender_document, FileUploader
    mount_uploader :home_check_document, FileUploader
    mount_uploader :match_application_document, FileUploader
    mount_uploader :adoption_application_document, FileUploader
    mount_uploader :adoption_contract_document, FileUploader
    mount_uploader :vetting_document, FileUploader

    belongs_to :primary_breed, :class_name => 'Breed'
    
    belongs_to :status, :class_name => 'StatusType'
    belongs_to :coordinator, :class_name => 'User'
    belongs_to :sub_status, :class_name => 'SubStatusType'
    belongs_to :marketing, :class_name => 'MarketingType'
    
    belongs_to :secondary_breed, :class_name => 'Breed'

    def age()
        return ((Time.now.to_i  - birthday.to_datetime.to_i )  / 1.year).to_i

    end
    def location()


        if(status.name == "Intake")
            current = Intake.where(:animal_id => id, :current_entry  => true)[0]
            if(current == nil)
                return "At Intake but no location"
            end
            return AnimalFacility.find(current.animal_facility_id).name
         
        elsif(status.name == "Foster")
            @foster = FosterStatus.where(:animal_id => id, :current_entry => true)[0]
            if(@foster == nil)
                return "At Foster but no location"
            end
            if @foster.foster_id != nil
              @foster = Foster.find_by id: @foster.foster_id    
              if @foster.user_id == nil and @foster.non_user_id != nil
                @fost_foster = NonUser.find(@foster.non_user_id).name
                @fost_email = NonUser.find(@foster.non_user_id).email
                return @fost_foster
              elsif @foster.user_id != nil and @foster.non_user_id == nil
                @fost_foster = User.find(@foster.user_id).name
                @fost_email = User.find(@foster.user_id).email
                return @fost_foster
              end

            else
                return "Foster but not assigned"
            end

        elsif(status.name == "Vetting")
            current = Vetting.where(:animal_id => id, :current_entry  => true)[0]
            if(current == nil)
                return "At Vetting but no location"
            end
            return Veterinarian.find(current.curr_vet_id).name

        elsif(status.name == "With Adopter")
            a = Adopted.where(:animal_id => id, :current_entry => true)[0]
            if(a == nil)
                return "At Adopter but no location"
            end
            if a.adopter_id != nil
              @adopter = Adopter.find_by id: a.adopter_id
              
              if @adopter.user_id == nil and @adopter.non_user_id != nil
                @adopt_adopt = NonUser.find(@adopter.non_user_id).name
                @adopt_email = NonUser.find(@adopter.non_user_id).email
                @adopt_adopt
              end
              if @adopter.user_id != nil and @adopter.non_user_id == nil
                @adopt_adopt = User.find(@adopter.user_id).name
                @adopt_email = User.find(@adopter.user_id).email
                return @adopt_adopt
              end
            else

                return "Adopted but adopter not set"
            end

        elsif(status.name == "In Training")
            current = Training.where(:animal_id => id, :current_entry  => true)[0]
            if(current == nil)
                return "At Training but no location"
            end
            return Trainer.find(current.trainer_id).name

        else
            return "UNDEFINED"

        end 

    end
end
