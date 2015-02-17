class User < ActiveRecord::Base
	validates :username, presence: true, uniqueness: true
	validates :realname, presence: true, length: {minimum: 4}
	validates :email, presence: true

  has_secure_password
  
  has_many :checked_hypotheses, dependent: :destroy
  has_many :exercise_hypotheses, through: :checked_hypotheses
end
