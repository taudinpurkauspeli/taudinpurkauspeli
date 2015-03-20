class Interview < ActiveRecord::Base
	validates :title, presence: true
	has_many :question_groups, dependent: :destroy
	has_many :questions, through: :question_groups
end
