class Adopted < ActiveRecord::Base
	#belongs_to :adopter, :class_name => 'Adopter'
	#belongs_to :animal, :class_name => 'Animal'
	#this is a many to many because there are many entries for same animal
	has_and_belongs_to_many :adopter, :class_name => 'Adopter'
	has_and_belongs_to_many :animal, :class_name => 'Animal'
	has_and_belongs_to_many :sub_status, :class_name => 'SubStatusType'
end
