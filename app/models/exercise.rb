class Exercise < ActiveRecord::Base
	has_many :tasks
	has_many :exercise_hypotheses
	has_many :hypotheses, through: :exercise_hypotheses
end
