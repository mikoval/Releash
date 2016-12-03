class Animal < ActiveRecord::Base
    validates :name, presence: true
    validates :species, presence: true
    mount_uploader :picture, AnimalPictureUploader
    belongs_to :species
    belongs_to :breed
end
