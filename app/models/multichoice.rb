class Multichoice < ActiveRecord::Base
	validates :question, presence: true

	belongs_to :subtask
	has_many :options, dependent: :destroy


	def check_right_answers(checked_options)

		right_answers = options.where(is_correct_answer:true).map(&:id).map!(&:to_s)

		if (right_answers - checked_options).empty?
			if(checked_options - right_answers).empty?
				return true
			else
				return false
			end
		else
			return false
		end

	end

end
