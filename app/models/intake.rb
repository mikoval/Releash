class Intake < ActiveRecord::Base
	belongs_to :foster, :class_name => 'User'
    belongs_to :vet, :class_name => 'Veterinarian'
    belongs_to :intake_hold, :class_name => 'hold_types'
end
