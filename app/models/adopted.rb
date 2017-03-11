class Adopted < ActiveRecord::Base
	belongs_to :adopter, :class_name => 'Adopter'
	belongs_to :animal, :class_name => 'Animal'
end
