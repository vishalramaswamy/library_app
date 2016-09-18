class User < ActiveRecord::Base
	has_many :reservations
	validates :username,presence: true, length: {maximum: 2}
	validates :password,presence: true, length: { minimum: 8}
end
