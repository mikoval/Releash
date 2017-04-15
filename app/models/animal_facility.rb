class AnimalFacility < ActiveRecord::Base
	self.table_name = "animal_facilities"
	validates :name, presence: true, uniqueness: { case_sensitive: false }
end
