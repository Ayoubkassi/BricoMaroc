class User < ApplicationRecord
    # i should perform some validtaion ofc here 
    has_secure_password # this one will use bycrypt to enctrypt our model
    has_one :profile
    
    #basic info that we will need 
    validates  :username, presence: true, uniqueness: true
    validates  :password,  presence: true, length: {minimum: 6}, allow_nil: true
end
