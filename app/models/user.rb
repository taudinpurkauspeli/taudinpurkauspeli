class User < ActiveRecord::Base
	validates :username, presence: true, uniqueness: true
	validates :realname, presence: true, length: {minimum: 4}
	validates :email, presence: true

	has_secure_password
end
