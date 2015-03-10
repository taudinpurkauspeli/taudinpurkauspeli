class CheckedHypothesis < ActiveRecord::Base

  validates :exercise_hypothesis_id, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :exercise_hypothesis

  has_one :hypothesis, through: :exercise_hypothesis
  has_one :exercise, through: :exercise_hypothesis
  has_one :hypothesis_group, through: :exercise_hypothesis and :hypothesis

  def get_explanation
    notice = "Työhypoteesi \"" + exercise_hypothesis.hypothesis.name + "\" poissuljettu."
    unless exercise_hypothesis.explanation.nil?
      notice += " Perustelu: " + exercise_hypothesis.explanation
    end
    return notice
  end
end
