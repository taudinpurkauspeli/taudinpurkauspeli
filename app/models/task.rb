class Task < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 2}, uniqueness: {scope: :exercise_id}
  belongs_to :exercise

  has_many :completed_tasks, dependent: :destroy
  has_many :users, through: :completed_tasks
  has_many :subtasks, -> {order('level')}, dependent: :destroy
  has_many :task_texts, through: :subtasks
  has_many :multichoices, through: :subtasks
  has_many :interviews, through: :subtasks
  has_many :conclusions, through: :subtasks
  has_many :exercise_hypotheses

  amoeba do
    enable
    include_association :subtasks
  end

  def self.get_highest_level(exercise)
    highest_level = exercise.tasks.maximum("level")
    unless highest_level.nil?
      return highest_level
    else
      return 0
    end
  end

  def move_up
    children = exercise.tasks.where("level > ?", level)
    siblings = exercise.tasks.where level:level
    if siblings.count > 1 then
      children.each do |task|
        task.update(level: task.level + 1)
      end
      siblings.each do |task|
        if task != self
          task.update(level: task.level + 1)
        end
      end
    else
      if level > 1 then
        children.each do |task|
          task.update(level: task.level - 1)
        end
        update(level: level - 1)
      end
    end
  end

  def move_level_up(new_level)
    children = exercise.tasks.where("level > ?", level)
    siblings = exercise.tasks.where level:level
    if siblings.count > 1 then
      update(level: new_level)
    else
      if level > 1 then
        children.each do |task|
          task.update(level: task.level - 1)
        end
        update(level: new_level)
      end
    end
  end

  def move_task_up(new_level)

    siblings = exercise.tasks.where level:level

    if siblings.count > 1 then
      update(level: new_level)
      new_siblings = exercise.tasks.where level:new_level
      children = exercise.tasks.where("level > ?", new_level)

      children.each do |task|
        task.update(level: task.level + 1)
      end
      new_siblings.each do |task|
        if task != self
          task.update(level: task.level + 1)
        end
      end

    else
      if level > 1 then
        move_level_up(new_level)

        new_siblings = exercise.tasks.where level:level
        children = exercise.tasks.where("level > ?", level)

        children.each do |task|
          task.update(level: task.level + 1)
        end
        new_siblings.each do |task|
          if task != self
            task.update(level: task.level + 1)
          end
        end

      end
    end
  end

  def move_down
    children = exercise.tasks.where("level > ?", level)
    siblings = exercise.tasks.where level:level
    if siblings.count > 1 then
      children.each do |task|
        task.update(level: task.level + 1)
      end
      update(level: level+1)
    else
      children.each do |task|
        task.update(level: task.level - 1)
      end
    end
  end

  def move_level_down(new_level)
    children = exercise.tasks.where("level > ?", level)
    siblings = exercise.tasks.where level:level
    if siblings.count > 1 then
      update(level: new_level)
    else
      children.each do |task|
        task.update(level: task.level - 1)
      end
    end
  end

  def short_name
    return_string = ''
    if name.split.size > 3
      return_string += name.split[0...3].join(' ') + ' ...'
    else
      return name
    end
    return return_string
  end

  def reset_prerequisites

    anamnesis = exercise.tasks.where(name: "Anamneesi").first
    exercise_hypotheses.each do |ex_hyp|
      ex_hyp.update(task:anamnesis)
    end

  end
end
