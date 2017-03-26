class Training < ActiveRecord::Base
    has_and_belongs_to_many :sub_status, :class_name => 'SubStatusType'
    has_and_belongs_to_many :trainer, :class_name => 'Trainer'
    has_and_belongs_to_many :animal, :class_name => 'Animal'
end
