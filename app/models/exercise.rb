class Exercise < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true, length: {minimum: 2}

	has_many :tasks
  
	has_many :exercise_hypotheses, -> { order('hypotheses.name')}, dependent: :destroy
	has_many :hypotheses, through: :exercise_hypotheses
	has_many :checked_hypotheses, through: :exercise_hypotheses
end
