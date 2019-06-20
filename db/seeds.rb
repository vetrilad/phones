require 'bcrypt'
require_relative '../models/user'

def hash_password(password)
  BCrypt::Password.create(password).to_s
end

MyTelecom::User.create(name: "admin", password: hash_password('admin'))
