class Animal < ActiveRecord::Base
    validates :name, presence: true

    mount_uploader :picture, AnimalPictureUploader
    belongs_to :primary_breed, :class_name => 'Breed'
    belongs_to :secondary_breed, :class_name => 'Breed'
end
