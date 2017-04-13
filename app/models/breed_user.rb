class BreedUser < ActiveRecord::Base
	belongs_to :user, :class_name => 'User'
	belongs_to :breed, :class_name => 'Breed'
end
