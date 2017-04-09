class Intake < ActiveRecord::Base
    has_and_belongs_to_many :sub_status, :class_name => 'SubStatusType'
    has_and_belongs_to_many :animal_facility, :class_name => 'AnimalFacility'
    has_and_belongs_to_many :animal, :class_name => 'Animal'
    has_and_belongs_to_many :intake_reason, :class_name => 'IntakeReason'

    validates :intake_date, presence: true
end
