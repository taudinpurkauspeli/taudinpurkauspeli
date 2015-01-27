class Hypothesis < ActiveRecord::Base
	has_many :exercise_hypotheses
	has_many :exercises, through: :exercise_hypotheses
end
