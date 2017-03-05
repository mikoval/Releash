class Training < ActiveRecord::Base
	belongs_to :itrain_hold, :class_name => 'hold_types'
end
