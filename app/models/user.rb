class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true, length: { minimum: 3 }
  validates :last_name, presence: true, length: { minimum: 3 }
  validates :email, presence: true
  validates :student_number, presence: true, uniqueness: true , length: { is: 9 }
  validates :starting_year, presence: true
  validates_format_of :student_number, with: /\A\d+\z/i

  has_secure_password

  has_many :asked_questions, dependent: :destroy
  has_many :questions, through: :asked_questions

  has_many :checked_hypotheses, dependent: :destroy
  has_many :exercise_hypotheses, through: :checked_hypotheses

  has_many :completed_tasks, dependent: :destroy
  has_many :tasks, through: :completed_tasks
  has_many :started_exercises, -> { order('name')}, through: :tasks, source: :exercise

  has_many :completed_subtasks, dependent: :destroy

  has_many :completed_exercises
  has_many :exercises, through: :completed_exercises

  has_many :saved_exercises

  has_many :subtasks, through: :completed_subtasks

  has_many :log_entries

  def has_completed?(completable_object)
    if completable_object.class == Subtask
      return !(subtasks.find_by id:completable_object.id).nil?
    elsif completable_object.class == Task
      return !(tasks.find_by id:completable_object.id).nil?
    elsif completable_object.class == Exercise
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
    unless has_completed?(subtask)
      completed_subtasks.create(subtask:subtask)
      task = subtask.task
      if subtask == task.subtasks.last
        complete_task(task)
      end
    end
  end

  def complete_task(task)
    unless has_completed?(task)
      completed_tasks.create(task:task)
      exercise = task.exercise
      if exercise.tasks.where(level:1...999).count == tasks.where(exercise:exercise).count
        complete_exercise(exercise)
      end
    end
  end

  def complete_exercise(exercise)
    unless has_completed?(exercise)
      completed_exercises.create(exercise:exercise)
      saved_exercises.create(exercise:exercise, completion_percent: 100, description: "Case suoritettu onnistuneesti")
    end
  end

  def restart_exercise(exercise)
    completion_percent = get_percent_of_completed_tasks_of_exercise(exercise)
    saved_exercises.create(exercise:exercise, completion_percent: completion_percent, description: "Case aloitettu uudelleen")
    checked_hypotheses.joins(:exercise_hypothesis).where(exercise_hypotheses: {exercise_id: exercise.id}).destroy_all
    completed_exercises.where(exercise_id: exercise.id).destroy_all
    completed_tasks.joins(:exercise).where(exercises: {id: exercise.id}).destroy_all
    completed_subtasks.joins(subtask: [:task]).where(subtasks: {tasks: {exercise_id: exercise.id}}).destroy_all
    asked_questions.joins(question: [interview: [subtask: [:task]]]).where(questions: {interviews: {subtasks: {tasks: {exercise_id: exercise.id}}}}).destroy_all
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

  def completable_subtasks(task)

    subtasks_to_return = Array.new

    task.subtasks.each do |subtask|
      if can_complete_subtask?(task, subtask)
        subtasks_to_return.push(subtask)
      end
    end

    return subtasks_to_return

  end

  def get_started_exercises_with_completion_percent
    currently_started_exercises = started_exercises.distinct

    user_exercises = Array.new()

    currently_started_exercises.each do |exercise|
      percent_of_completed_tasks = get_percent_of_completed_tasks_of_exercise(exercise)

      json_exercise = exercise.as_json

      json_exercise["percent_of_completed_tasks"] = percent_of_completed_tasks
      user_exercises << json_exercise
    end

    return user_exercises

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
    return tasks.where(exercise:exercise).count
  end

  def get_percent_of_completed_tasks_of_exercise(exercise)
    exercise_tasks_count = exercise.tasks.where(level: 1...99).count

    if exercise_tasks_count == 0
      return 0
    else
      return (get_number_of_completed_tasks_by_exercise(exercise) * 100) / (exercise_tasks_count)
    end
  end
end