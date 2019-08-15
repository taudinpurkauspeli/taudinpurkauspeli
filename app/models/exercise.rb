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

  def has_conclusion?
    conclusion = Conclusion.includes(:task).where(tasks:{exercise_id: id})
    return !conclusion.empty?
  end

  def correct_diagnosis
    conclusion = Conclusion.includes(:task).where(tasks:{exercise_id: id})

    unless conclusion.empty?
      return conclusion.first.exercise_hypothesis
    end
    return nil
  end

  def get_conclusion
    conclusion = Conclusion.includes(:task).where(tasks:{exercise_id: id})

    unless conclusion.empty?
      return conclusion.first
    end
    return nil
  end

  def get_hypotheses
    return exercise_hypotheses.group_by{|exhyp| exhyp.hypothesis.hypothesis_group_id}
  end

  def get_hypotheses_json
    result = exercise_hypotheses.group_by{|exhyp| exhyp.hypothesis.hypothesis_group.name}
    return result.slice(*result.keys.sort).to_json(include: :hypothesis)
  end

  def get_hypothesis_bank
    return (Hypothesis.all - hypotheses).group_by(&:hypothesis_group_id)
  end

  def get_hypothesis_bank_json
    return (Hypothesis.all - hypotheses).group_by(&:hypothesis_group_id).to_json(include: :hypothesis_group)
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

  def get_tasks_by_level_json
    return tasks.where("level > ?", 0).order(:level).group_by{|t| t.level}.map{|item| item}
  end

  def get_tasks_json
    return tasks.order(:name)
  end

  def create_duplicate(exercise)
    exercise_dup = exercise.amoeba_dup
    new_name = exercise.name + " (kopio)"
    exercise_dup.name = new_name
    if exercise_dup.save

      exercise_dup.tasks.where(name: "Anamneesi (tekninen kopio)").destroy_all

      exercise_dup.exercise_hypotheses.each do |ex_hyp|

        new_prerequisite_task = exercise_dup.tasks.where(name: ex_hyp.task.name).first

        ex_hyp.update(task: new_prerequisite_task)
      end

      old_conclusion = exercise.get_conclusion
      if old_conclusion
        old_correct_diagnosis = exercise.correct_diagnosis

        if old_correct_diagnosis

          new_conclusion = exercise_dup.get_conclusion
          new_correct_diagnosis = exercise_dup.exercise_hypotheses.where(hypothesis_id: old_correct_diagnosis.hypothesis_id).first

          new_conclusion.update(exercise_hypothesis: new_correct_diagnosis)
        end

      end

      return true
    end

    return false
  end

  def get_users(year)

    users_of_ex = Array.new()

    if year.nil? || year == 0 || year == "0"
      tasks.each do |task|
        users_of_ex += task.users
      end
    else
      tasks.each do |task|
        users_of_ex += task.users.where("starting_year = ?", year)
      end
    end

    return  users_of_ex.uniq
  end

  def get_all_users(exercise)

    users_of_ex = Array.new()

    tasks.each do |task|
      all_users = task.users.select("id", "username", "email", "student_number", "starting_year", "admin", "first_name", "last_name")
      addable_users = Array.new()
      all_users.each do |user|
        percent_of_completed_tasks = user.get_percent_of_completed_tasks_of_exercise(exercise)
        json_user = user.as_json
        json_user["percent_of_completed_tasks"] = percent_of_completed_tasks
        addable_users << json_user
      end
      users_of_ex += addable_users
    end

    return  users_of_ex.uniq
  end

  def restart(user)
    user.restart_exercise(self)
    return true
  end

  private
  def create_anamnesis
    tasks.create(name: "Anamneesi", level: 0)
  end
end
