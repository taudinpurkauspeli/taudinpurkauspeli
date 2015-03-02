class Exercise < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true, length: {minimum: 2}

	has_many :tasks
  
  has_many :hypotheses, through: :exercise_hypotheses
	has_many :exercise_hypotheses, -> { includes(:hypothesis).order('hypotheses.name')}, dependent: :destroy
	has_many :checked_hypotheses,  -> { includes(:hypothesis).order('hypotheses.name')}, through: :exercise_hypotheses
end
