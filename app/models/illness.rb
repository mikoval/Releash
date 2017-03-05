class Illness < ActiveRecord::Base
	belongs_to :ill_vet, :class_name => 'Veterinarian'
end
