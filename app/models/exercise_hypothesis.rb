class ExerciseHypothesis < ActiveRecord::Base

  before_destroy :update_conclusion_exercise_hypothesis_id

  belongs_to :exercise
  belongs_to :hypothesis
  belongs_to :task

  has_many :checked_hypotheses, dependent: :destroy
  has_many :users, through: :checked_hypotheses
  has_many :conclusions

  has_one :hypothesis_group, through: :hypothesis

  amoeba do
    enable
    exclude_association [:checked_hypotheses, :users, :hypothesis_group, :hypothesis, :exercise]
  end

  def get_prerequisite
    return task
  end

  def user_meets_requirements (user)
    return true if task.level < 1
    if user.completed_tasks.where(task_id: task_id).empty?
      return false
    end
    return true
  end

  def name
    return hypothesis.name
  end

  def get_explanation
    notice = "\"" + hypothesis.name + "\" poissuljettu."
    unless explanation.nil?
      notice += " Perustelu: " + explanation
    end
    return notice
  end

  def get_right_explanation
    notice = "Onnittelut! Sait selville, että kyseessä oli " + hypothesis.name  + ". Mitä sinun tulee vielä tehdä?"
    unless explanation.nil?
      notice += " Perustelu: " + explanation
    end
    return notice
  end

  def update_conclusion_exercise_hypothesis_id
    conclusions.each do |conclusion|
      conclusion.update(exercise_hypothesis_id: nil)
    end
  end

end
