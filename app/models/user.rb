require 'bcrypt'

class User < ActiveRecord::Base
    has_many :hazards
    validates :email, uniqueness: true 
    validates :email, :password, presence: true 
    
    include BCrypt

    def password
      @password ||= Password.new(password_hash)
    end
    
    def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    end
end