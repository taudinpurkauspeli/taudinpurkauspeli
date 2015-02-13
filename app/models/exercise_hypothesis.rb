class ExerciseHypothesis < ActiveRecord::Base
  validates :exercise_id, presence: true
  validates :hypothesis_id, presence: true

	belongs_to :exercise
	belongs_to :hypothesis

  has_many :checked_hypotheses
  has_many :users, through: :checked_hypotheses
end
