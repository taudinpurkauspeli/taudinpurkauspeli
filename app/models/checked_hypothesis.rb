class CheckedHypothesis < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise_hypothesis
end
