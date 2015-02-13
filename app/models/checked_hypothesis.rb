class CheckedHypothesis < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise_hypothesis

  has_one :hypothesis,  through: :exercise_hypothesis
  has_one :exercise,  through: :exercise_hypothesis
end
