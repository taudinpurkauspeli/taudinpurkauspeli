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
    customize(lambda { |original_task,new_task|
      if original_task.name == "Anamneesi"
        new_task.name = "Anamneesi (tekninen kopio)"
      end
    })
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

    if siblings.count > 1
      move_children_down(children)
      move_siblings_down(siblings)

    else
      if level > 1
        move_children_up(children)
        update(level: level - 1)
      end
    end

  end

  def move_level_up(new_level)
    children = exercise.tasks.where("level > ?", level)
    siblings = exercise.tasks.where(level:level).count

    if siblings > 1
      update(level: new_level)

    else
      if level > 1
        move_children_up(children)
        update(level: new_level)
      end
    end

  end

  def move_task_up(new_level)

    siblings = exercise.tasks.where(level:level).count

    if siblings > 1
      update(level: new_level)

      new_siblings = exercise.tasks.where level:new_level
      children = exercise.tasks.where("level > ?", new_level)

      move_children_down(children)
      move_siblings_down(new_siblings)

    else
      if level > 1
        move_level_up(new_level)

        new_siblings = exercise.tasks.where level:level
        children = exercise.tasks.where("level > ?", level)

        move_children_down(children)
        move_siblings_down(new_siblings)
      end
    end

  end

  def move_down
    children = exercise.tasks.where("level > ?", level)
    siblings = exercise.tasks.where(level:level).count

    if siblings > 1
      move_children_down(children)
      update(level: level+1)
    else
      move_children_up(children)
    end
  end

  def move_level_down(new_level)
    children = exercise.tasks.where("level > ?", level)
    siblings = exercise.tasks.where(level:level).count

    if siblings > 1
      update(level: new_level)
    else
      move_children_up(children)
      update(level: (new_level - 1))
    end
  end

  def move_task_down(new_level)

    siblings = exercise.tasks.where(level:level).count

    if siblings > 1
      update(level: new_level)
      new_siblings = exercise.tasks.where level:new_level
      children = exercise.tasks.where("level > ?", new_level)

      move_children_down(children)
      move_siblings_down(new_siblings)

    else
      move_level_down(new_level)

      new_siblings = exercise.tasks.where level:level
      children = exercise.tasks.where("level > ?", level)

      move_children_down(children)
      move_siblings_down(new_siblings)
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

  private

  def move_children_up(children)
    children.each do |task|
      task.update(level: task.level - 1)
    end
  end

  def move_children_down(children)
    children.each do |task|
      task.update(level: task.level + 1)
    end
  end

  def move_siblings_down(siblings)
    siblings.each do |task|
      if task != self
        task.update(level: task.level + 1)
      end
    end
  end


end
