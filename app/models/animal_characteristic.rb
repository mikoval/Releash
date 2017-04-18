class AnimalCharacteristic < ActiveRecord::Base
    belongs_to :characteristic
    belongs_to :animal, :class_name => 'Animal'
end
