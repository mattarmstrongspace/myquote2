class User < ApplicationRecord

    #adding methods to set and authenticate against a bcrypt password (for login purposes)
    has_secure_password
    
    #if user is deleted, its quotes are also deleted
    has_many :quotes, dependent: :destroy
end
