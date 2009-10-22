class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  attr_reader :password

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(pwd, self.salt)
  end

  #Returns a user if the supplied email and password
  #match the database record
  def User.authenticate(email, password)
    user = User.find_by_email email
    if user
      password_attempt = User.encrypted_password(password, user.salt)
      if password_attempt != user.hashed_password
        user = nil
      end
    end
    return user
  end

  private
   #Generates random value to be stored in database
   def create_new_salt
     self.salt = Digest::SHA256.hexdigest(Time.now.to_s + rand.to_s)
   end

   #Given a password and a generated salt
   #Returns hashed parrword
   def User.encrypted_password(pwd, salt)
     string_to_hash = pwd + salt
     Digest::SHA256.hexdigest(string_to_hash)
   end
end
