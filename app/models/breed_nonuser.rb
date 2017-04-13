class BreedNonuser < ActiveRecord::Base
	belongs_to :non_user, :class_name => 'NonUser'
	belongs_to :breed, :class_name => 'Breed'
end
