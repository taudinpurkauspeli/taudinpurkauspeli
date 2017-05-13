class Question < ActiveRecord::Base
	validates :title_string, presence: true
	validates :content, presence: true

	belongs_to :interview
	belongs_to :question_group
	belongs_to :title

	accepts_nested_attributes_for :question_group, :reject_if => :check_question_group

	enum required: %i(allowed required wrong)

	amoeba do
		enable
	end

	def init_new_question_group
		return self.build_question_group
	end

	private

	def check_question_group(question_group_attributes)

		if question_group_attributes['title'].blank?

			return handle_empty_group

		elsif _question_group = QuestionGroup.find_by(title:question_group_attributes['title'])

			self.question_group = _question_group
			return true

		end
		return false
	end

	def handle_empty_group

		old_question_group = self.question_group
		self.question_group = nil

		if !old_question_group.nil? && old_question_group.questions.count == 1
			old_question_group.destroy
		end
		return true

	end

end
