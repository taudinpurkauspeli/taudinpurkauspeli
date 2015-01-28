class ExerciseHypothesis < ActiveRecord::Base
	belongs_to :exercise
	belongs_to :hypothesis
end
