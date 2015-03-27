class QuestionGroup < ActiveRecord::Base
	
	has_many :questions, dependent: :destroy
end
