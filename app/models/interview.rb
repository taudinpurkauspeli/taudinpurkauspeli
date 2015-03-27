class Interview < ActiveRecord::Base
	validates :title, presence: true

	belongs_to :subtask
	has_many :questions, dependent: :destroy

	def user_has_asked_all_required(user)
    user.questions
  end
end
