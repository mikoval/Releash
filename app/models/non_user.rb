class NonUser < ActiveRecord::Base
	self.table_name = "non_users"
    
    before_save   :downcase_email
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validate  :picture_size
    mount_uploader :picture, PictureUploader
     
    private
        # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
    def downcase_email
      self.email = email.downcase
    end
    
end
