class Illness < ActiveRecord::Base
	belongs_to :ill_vet, :class_name => 'Veterinarian'
	belongs_to :animal, :class_name => 'Animal'
end
