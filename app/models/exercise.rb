class Exercise < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 2}
    # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  after_create :create_anamnesis

  has_many :tasks, dependent: :destroy
  has_many :exercise_hypotheses, -> { includes(:hypothesis).order('hypotheses.name')}, dependent: :destroy
  has_many :hypotheses, through: :exercise_hypotheses
  has_many :checked_hypotheses,  -> { includes(:hypothesis).order('hypotheses.name')}, through: :exercise_hypotheses
  has_attached_file :picture, styles: {
    full: '1070>',
    thumb: '100x100#'
  }
  amoeba do
    enable
    include_association :exercise_hypotheses
    include_association :tasks
  end

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

  def create_duplicate(exercise)
    exercise_dup = exercise.amoeba_dup
    if exercise_dup.save
      exercise_dup.exercise_hypotheses.each do |ex_hyp|

        new_prerequisite_task = exercise_dup.tasks.where(name: ex_hyp.task.name).first

        ex_hyp.update(task: new_prerequisite_task)
      end

      return true
    end

    return false
  end

  private
  def create_anamnesis
    tasks.create(name:"Anamneesi", level:0)
  end
end
