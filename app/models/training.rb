class Training < ActiveRecord::Base
	belongs_to :train_hold, :class_name => 'HoldType'
	belongs_to :animal, :class_name => 'Animal'
end
