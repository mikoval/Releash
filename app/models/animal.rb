class Animal < ActiveRecord::Base
    validates :name, presence: true
    validates :species, presence: true
    mount_uploader :picture, AnimalPictureUploader
    mount_uploader :documents, FileUploader
    belongs_to :species
end
