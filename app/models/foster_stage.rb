class FosterStage < ActiveRecord::Base
	belongs_to :curr_fost, :class_name => 'User'
    belongs_to :fost_hold, :class_name => 'hold_types'
end
