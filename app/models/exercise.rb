class Exercise < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true, length: {minimum: 2}
  after_create :create_anamnesis
	has_many :tasks
  
  has_many :hypotheses, through: :exercise_hypotheses
	has_many :exercise_hypotheses, -> { includes(:hypothesis).order('hypotheses.name')}, dependent: :destroy
	has_many :checked_hypotheses,  -> { includes(:hypothesis).order('hypotheses.name')}, through: :exercise_hypotheses

  def get_hypotheses
    return exercise_hypotheses.group_by{|exhyp| exhyp.hypothesis.hypothesis_group_id}
  end

  def get_hypothesis_bank
    return (Hypothesis.all - hypotheses).group_by(&:hypothesis_group_id)
  end

  def get_checked_hypotheses_for(user)
    return checked_hypotheses.where(user_id: user.id).group_by{|checkhyp| checkhyp.hypothesis.hypothesis_group_id }
  end

  def get_unchecked_hypotheses_for(user)
    return (exercise_hypotheses - user.exercise_hypotheses).group_by{|exhyp| exhyp.hypothesis.hypothesis_group_id}
  end

  def get_number_of_tasks_by_level(level)
    tasks.where(level: level).count
  end

  private
  def create_anamnesis
    tasks.create(name:"Anamneesi", level:0)
  end
end
