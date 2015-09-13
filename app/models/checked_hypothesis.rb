class CheckedHypothesis < ActiveRecord::Base

  validates :exercise_hypothesis_id, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :exercise_hypothesis

  has_one :hypothesis, through: :exercise_hypothesis
  has_one :exercise, through: :exercise_hypothesis
  has_one :hypothesis_group, through: :exercise_hypothesis and :hypothesis

  def get_explanation
    return exercise_hypothesis.get_explanation
  end
end
