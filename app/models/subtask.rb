class Subtask < ActiveRecord::Base

	validates :task_id, presence: true

	belongs_to :task

	has_one :task_text, dependent: :destroy
	has_one :multichoice, dependent: :destroy

	def to_s
		return_string = 'Alitoimenpide'
		content = ''

		unless task_text.nil?
			return_string = 'Teksti: '
			content = task_text.content
			
		end
		unless multichoice.nil?
			return_string = 'Monivalintakysymys: '
			content = multichoice.question

		end
		return_string += content.split[0...3].join(' ') + ' ...'
		return return_string
	end
end
