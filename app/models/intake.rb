class Intake < ActiveRecord::Base
	has_and_belongs_to_many :foster, :class_name => 'Foster'
    has_and_belongs_to_many :vet, :class_name => 'Veterinarian'
    has_and_belongs_to_many :sub_status, :class_name => 'SubStatusType'
    has_and_belongs_to_many :animal_facility, :class_name => 'AnimalFacility'
    has_and_belongs_to_many :animal, :class_name => 'Animal'

    validates :intake_date, presence: true
end
