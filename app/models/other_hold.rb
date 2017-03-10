class OtherHold < ActiveRecord::Base
	belongs_to :animal, :class_name => 'Animal'
	
end
