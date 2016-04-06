class CheckedHypothesis < ActiveRecord::Base

  validates :exercise_hypothesis_id, presence: true
  validates :user_id, presence: true
  validate :cannot_check_same_hypothesis_many_times

  belongs_to :user
  belongs_to :exercise_hypothesis

  has_one :hypothesis, through: :exercise_hypothesis
  has_one :exercise, through: :exercise_hypothesis
  has_one :hypothesis_group, through: :exercise_hypothesis and :hypothesis

  def cannot_check_same_hypothesis_many_times

    if user_id.present? && exercise_hypothesis_id.present?
      how_many_checked_hypotheses = CheckedHypothesis.where(user_id: user_id, exercise_hypothesis_id: exercise_hypothesis_id)
      if how_many_checked_hypotheses.count > 0
        errors.add(:base, 'User has already checked this hypothesis')
      end
    end
  end

  def get_explanation
    return exercise_hypothesis.get_explanation
  end

  def get_right_explanation
    return exercise_hypothesis.get_right_explanation
  end
end
