class Task < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 2}
	belongs_to :exercise

  has_many :completed_tasks, dependent: :destroy
  has_many :users, through: :completed_tasks

  has_many :subtasks, dependent: :destroy

  has_many :task_texts, through: :subtasks

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
      children.each do |task|
        task.level += 1
        task.save
      end
      siblings.each do |task|
        task.level += 1
        task.save
      end
      level -= 1
      save
    else
      children.each do |task|
        task.level -= 1
        task.save
      end
    end
  end

  def move_down
    children = exercise.tasks.where("level > ?", level)
    siblings = exercise.tasks.where level:level
    if siblings.count > 1
      children.each do |task|
        task.level += 1
        task.save
      end
      level += 1
      save
    else
      children.each do |task|
        task.level -= 1
        task.save
      end  
    end
  end

#  def get_highest_level(exercise)
#    e = exercise.tasks
#    e.maximum("level")
#  end
end
