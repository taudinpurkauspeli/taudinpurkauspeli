class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :realname, presence: true, length: { minimum: 4 }
  validates :email, presence: true

  has_secure_password

  has_many :asked_questions, dependent: :destroy
  has_many :questions, through: :asked_questions

  has_many :checked_hypotheses, dependent: :destroy
  has_many :exercise_hypotheses, through: :checked_hypotheses

  has_many :completed_tasks, -> {order('created_at DESC')}, dependent: :destroy
  has_many :tasks, through: :completed_tasks
  has_many :completed_subtasks, dependent: :destroy

  has_many :subtasks, through: :completed_subtasks

  def has_asked_all_required_questions_of(interview)
    asked = questions.where(interview:interview).where(required:true)
    required = interview.questions.where(required:true)
    return (asked - required).empty? && (required - asked).empty?
  end

  def has_completed?(completable_task)
    if completable_task.class == Subtask
      return !completed_subtasks.where(subtask:completable_task).empty?
    end
    if completable_task.class == Task
      return !completed_tasks.where(task:completable_task).empty?
    end
  end

  def can_start?(task)
    if task.level == 1
      return true
    else
      get_number_of_tasks_by_level(task.exercise, task.level - 1) == task.exercise.get_number_of_tasks_by_level(task.level - 1)
    end
  end

  def complete_subtask(subtask)
    completed_subtasks.create(subtask:subtask)
    task_in_progress = subtask.task
    if task_in_progress.subtasks.last == subtask
      complete_task(task_in_progress)
    end
  end

  def complete_task(task)
    completed_tasks.create(task:task)
  end

  def ask_question(question)
    asked_questions.create(question:question)
  end

  def can_complete_subtask?(task, subtask)
    last_subtask_level = subtasks.where(task:task).maximum("level")
    # user has completed some subtasks
    unless last_subtask_level.nil?
      # get first subtasks whose level >= user's last completed subtask
      next_sub = (task.subtasks.where(level:last_subtask_level + 1...999).limit 1)[0]
      if next_sub == subtask || last_subtask_level >= subtask.level
        return true
      else
        return false
      end
      # user has not completed any subtasks
    else
      # user is trying to do the first subtask of a task
      if subtask.level == task.subtasks.minimum("level")
        return true
      end
    end
    return false
  end

  def get_number_of_tasks_by_level(exercise, level)
    number_of_tasks = 0
    completed_tasks.each do |c|
      unless c.task.nil?
        if(c.task.level == level && c.task.exercise_id == exercise.id)
          number_of_tasks += 1
        end
      end
    end
    return number_of_tasks
  end

  def has_completed_task(id)
    return completed_tasks.where(id:id).nil?
  end

  def has_asked_question?(question)
    return !asked_questions.where(question:question).empty?
  end

  def has_checked_hypothesis?(exercise_hypothesis)
    return !checked_hypotheses.where(exercise_hypothesis:exercise_hypothesis).empty?
  end

  def get_checked_hypothesis(exercise_hypothesis)
    return checked_hypotheses.where(exercise_hypothesis:exercise_hypothesis).first
  end

  def get_number_of_completed_tasks_by_exercise(exercise)
    return completed_tasks.select{ |ct| ct.has_exercise?(exercise)}.count
  end

  def get_percent_of_completed_tasks_of_exercise(exercise)
    return (get_number_of_completed_tasks_by_exercise(exercise) * 100) / exercise.tasks.count
  end

end