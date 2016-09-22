class User < ActiveRecord::Base
	has_secure_password
	has_many :reservations
	validates :username,presence: true,:uniqueness => true
	validates :password,presence: true, length: { minimum: 8}
	validates :email, email_format: {message: "Invalid E-Mail"},:uniqueness => true
end
