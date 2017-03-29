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
    belongs_to :sub_status, :class_name => 'SubStatusType'
    belongs_to :marketing, :class_name => 'MarketingType'
    
    belongs_to :secondary_breed, :class_name => 'Breed'
end
