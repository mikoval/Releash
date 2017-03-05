class Adopted < ActiveRecord::Base
	belongs_to :adopter, :class_name => 'Adopter'
end
