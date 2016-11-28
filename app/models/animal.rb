class Animal < ActiveRecord::Base
    validates :name, presence: true
    validates :species, presence: true
    belongs_to :species
end
