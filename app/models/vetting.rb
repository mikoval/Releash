class Vetting < ActiveRecord::Base
	self.table_name = "vettings"
	has_and_belongs_to_many :curr_fost, :class_name => 'Foster'
    has_and_belongs_to_many :curr_vet, :class_name => 'Veterinarian'
    has_and_belongs_to_many :sub_status, :class_name => 'SubStatusType'
    has_and_belongs_to_many :animal, :class_name => 'Animal'

    validates :vet_date, presence: true
end
