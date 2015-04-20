class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :realname, presence: true, length: { minimum: 4 }
  validates :email, presence: true
  validates :student_number, presence: true, uniqueness: true , length: { is: 9 }
  validates :starting_year, presence: true

  has_secure_password

  has_many :asked_questions, dependent: :destroy
  has_many :questions, through: :asked_questions

  has_many :checked_hypotheses, dependent: :destroy
  has_many :exercise_hypotheses, through: :checked_hypotheses

  has_many :completed_tasks, -> {order('created_at ASC')}, dependent: :destroy
  has_many :tasks, through: :completed_tasks
  has_many :completed_subtasks, dependent: :destroy
  has_many :completed_exercises
  has_many :exercises, through: :completed_exercises

  has_many :subtasks, through: :completed_subtasks

  def has_completed?(completable_object)
    if completable_object.class == Subtask
      return !(subtasks.find_by id:completable_object.id).nil?
    end
    if completable_object.class == Task
      return !(tasks.find_by id:completable_object.id).nil?
    end
    if completable_object.class == Exercise
      return !(exercises.find_by id:completable_object.id).nil?
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
    task = subtask.task
    if subtask == task.subtasks.last
      complete_task(task)
    end
  end

  def complete_task(task)
    completed_tasks.create(task:task)
    exercise = task.exercise
    if exercise.tasks.where(level:1...999).count == tasks.count
      complete_exercise(exercise)
    end
  end

  def complete_exercise(exercise)
    completed_exercises.create(exercise:exercise)
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
    tasks.where(level:level).where(exercise:exercise).count
  end

  def check_hypothesis(exhyp)
    checked_hypotheses.create(exercise_hypothesis:exhyp)
  end

  def check_all_hypotheses(exercise)
    exercise.exercise_hypotheses.each do |exhyp|
      unless has_checked_hypothesis?(exhyp)
        checked_hypotheses.create(exercise_hypothesis:exhyp)
      end
    end
  end
  
  def has_asked_question?(question)
    return !asked_questions.find_by(question:question).nil?
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
    if exercise.tasks.where(level: 1...99).count == 0
      return 0
    else
      return (get_number_of_completed_tasks_by_exercise(exercise) * 100) / (exercise.tasks.where(level: 1...99).count)
    end
  end
end