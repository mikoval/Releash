class Role < ActiveRecord::Base
    validates :title, presence: true
    has_many :users
end
