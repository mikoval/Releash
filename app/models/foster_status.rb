class FosterStatus < ActiveRecord::Base
	has_and_belongs_to_many :foster, :class_name => 'Foster'
	has_and_belongs_to_many :adopter, :class_name => 'Adopter'
    has_and_belongs_to_many :vet, :class_name => 'Veterinarian'
    has_and_belongs_to_many :sub_status, :class_name => 'SubStatusType'
    has_and_belongs_to_many :animal, :class_name => 'Animal'
end
