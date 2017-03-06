class Vetting < ActiveRecord::Base
	belongs_to :curr_fost, :class_name => 'User'
    belongs_to :curr_vet, :class_name => 'Veterinarian'
    belongs_to :vet_hold, :class_name => 'HoldType'
end
