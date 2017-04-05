class SubStatus < ActiveRecord::Base
	has_and_belongs_to_many :name, :class_name => 'SubStatusType'
    has_and_belongs_to_many :animal, :class_name => 'Animal'
end
