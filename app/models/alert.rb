class Alert < ActiveRecord::Base
	belongs_to :assignee, :class_name => 'User'
	belongs_to :created_by, :class_name => 'User'
    belongs_to :animal, :class_name => 'Animal'
    belongs_to :type, :class_name => 'AlertType'

    validates :title, presence: true
    validates :description, presence: true
    validates :alert_type_id, presence: true
    #validates :assignee_id, presence: true
    validates :created_by_id, presence: true
     def start_time
        self.date ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
    end
end
