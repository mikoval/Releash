class FosterStatus < ActiveRecord::Base
	has_and_belongs_to_many :foster, :class_name => 'Foster'
    has_and_belongs_to_many :sub_status, :class_name => 'SubStatusType'
    has_and_belongs_to_many :animal, :class_name => 'Animal'
    validates :foster_date, presence: true
end
