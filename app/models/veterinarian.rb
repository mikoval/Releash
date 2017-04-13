class Veterinarian < ActiveRecord::Base
	self.table_name = "veterinarian"
	validates :name, presence: true, uniqueness: { case_sensitive: false }
end
