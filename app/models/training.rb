class Training < ActiveRecord::Base
	belongs_to :train_hold, :class_name => 'HoldType'
end
