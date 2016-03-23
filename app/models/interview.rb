class Interview < ActiveRecord::Base
	validates :title, presence: true

	belongs_to :subtask, dependent: :destroy
	has_many :questions, dependent: :destroy
	has_many :question_groups, through: :questions

	amoeba do
		enable
		include_association :questions
	end

	def all_questions_asked_by?(user)
    asked = user.questions.where(interview:self).required
    required = questions.required
    return (asked - required).empty? && (required - asked).empty?
  end

  def to_s
    'Pohdinta'
  end
end
