class Species < ActiveRecord::Base
    validates :kind, presence: true
end
