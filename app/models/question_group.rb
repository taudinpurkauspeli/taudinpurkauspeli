class QuestionGroup < ActiveRecord::Base

	validates :title, presence: true

	has_many :questions

	def self.delete_unused_groups
		QuestionGroup.all.each do |qp|
			if qp.questions.empty?
				puts "POISTAN TÄMÄN:" + qp.title
				qp.delete
			end
		end
	end
end
