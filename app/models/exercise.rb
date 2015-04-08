class Exercise < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 2}
  after_create :create_anamnesis

  has_many :tasks, dependent: :destroy
  has_many :exercise_hypotheses, -> { includes(:hypothesis).order('hypotheses.name')}, dependent: :destroy
  has_many :hypotheses, through: :exercise_hypotheses
  has_many :checked_hypotheses,  -> { includes(:hypothesis).order('hypotheses.name')}, through: :exercise_hypotheses

  amoeba do
    enable
    include_association :exercise_hypotheses
    include_association :tasks
  end

  has_attached_file :picture, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

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
      exercise_dup.tasks.where(level:0).last.delete

      anamnesis_dup = exercise_dup.tasks.where(level:0).first

      exercise_dup.exercise_hypotheses.each do |ex_hyp|
        ex_hyp.update(task: anamnesis_dup)
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
