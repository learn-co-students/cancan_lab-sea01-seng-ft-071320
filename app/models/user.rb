class User < ApplicationRecord
   has_many :viewers
   has_many :readable, through: :viewers, source: :note

   def self.current_user
    self.find(session[:user_id])
   end
end
