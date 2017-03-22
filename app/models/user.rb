class User < ActiveRecord::Base
    attr_accessor :remember_token, :activation_token
    before_save   :downcase_email
    before_save :create_activation_digest
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    validate  :picture_size
    validates :role_id, presence: true
    mount_uploader :picture, PictureUploader
    belongs_to :role
 




    
    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    def self.new_token
        SecureRandom.urlsafe_base64
    end
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token)
    end
    def forget
        update_attribute(:remember_digest, nil)
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
    def create_activation_digest
       
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)

    end
    
end
