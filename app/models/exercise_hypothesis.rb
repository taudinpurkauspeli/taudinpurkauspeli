class ExerciseHypothesis < ActiveRecord::Base
	belongs_to :exercise
	belongs_to :hypothesis

  has_many :checked_hypotheses
  has_many :users, through: :checked_hypotheses
end
