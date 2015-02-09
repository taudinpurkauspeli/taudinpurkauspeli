class User < ActiveRecord::Base
	validates :username, presence: true, uniqueness: true
	validates :realname, presence: true, length: {minimum: 4}
	validates :email, presence: true
	#validates :password, presence: true, if: :password

	has_secure_password
end
