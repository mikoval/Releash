class Adopter < ActiveRecord::Base
	belongs_to :non_user, :class_name => 'NonUser'
	belongs_to :user, :class_name => 'User'	
end
