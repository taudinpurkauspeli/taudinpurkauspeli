class Interview < ActiveRecord::Base
	validates :title, presence: true

	belongs_to :subtask
	has_many :questions, dependent: :destroy
	has_many :question_groups, through: :questions

	def user_has_asked_all_required(user)
		user.questions
	end
end
