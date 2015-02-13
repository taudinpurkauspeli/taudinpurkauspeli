class Hypothesis < ActiveRecord::Base

	validates :name, presence: true, uniqueness: true

	has_many :exercise_hypotheses
	has_many :exercises, through: :exercise_hypotheses
  belongs_to :hypothesis_group
end
