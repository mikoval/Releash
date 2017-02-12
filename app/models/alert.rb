class Alert < ActiveRecord::Base
	belongs_to :assignee, :class_name => 'User'
	belongs_to :created_by, :class_name => 'User'
    belongs_to :animal, :class_name => 'Animal'
    belongs_to :type, :class_name => 'Type'

    validates :title, presence: true
    validates :description, presence: true
    validates :type, presence: true
    validates :assignee, presence: true
    validates :created_by, presence: true
    validates :description, presence: true
    validates :type, presence: true
    validates :assignee, presence: true
end
