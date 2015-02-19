class ExerciseHypothesis < ActiveRecord::Base
  validates :exercise_id, presence: true
  validates :hypothesis_id, presence: true

 # default_scope {includes(:hypothesis)}
 # default_scope {order('hypothesis.name ASC')}

	belongs_to :exercise
	belongs_to :hypothesis

  has_many :checked_hypotheses, dependent: :destroy
  has_many :users, through: :checked_hypotheses

  has_one :hypothesis_group, through: :hypothesis
end
