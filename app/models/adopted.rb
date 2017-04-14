class Adopted < ActiveRecord::Base
	#this is a many to many because there are many entries for same animal
	self.table_name = "adopteds"
	has_and_belongs_to_many :adopter, :class_name => 'Adopter'
	has_and_belongs_to_many :animal, :class_name => 'Animal'
	has_and_belongs_to_many :sub_status, :class_name => 'SubStatusType'
	validates :adopt_date, presence: true
end
