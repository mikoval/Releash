class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    validate  :picture_size
    mount_uploader :picture, PictureUploader
    belongs_to :role
 

    private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
    

    #setting constants for comparison 
    @@VOLUNTEER = 1
    @@EMPLOYEE = 2
    @@ADMIN = 3
    def self.ADMIN 
        @@ADMIN 
    end
    def self.VOLUNTEER 
        @@VOLUNTEER 
    end
    def self.EMPLOYEE 
        @@EMPLOYEE 
    end
end
