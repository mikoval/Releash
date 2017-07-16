class AnimalApplication < ActiveRecord::Base
	self.table_name = 'animal_applications'
	has_and_belongs_to_many :animal, :class_name => 'Animal'
	has_and_belongs_to_many :adopter, :class_name => 'Adopter'
	#validates :adopter_id, presence: true
	mount_uploader :adoption_document, FileUploader
	validates :app_date, presence: true

end
