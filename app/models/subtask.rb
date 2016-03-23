class Subtask < ActiveRecord::Base
  after_create :set_level

  belongs_to :task

  has_one :task_text
  has_one :multichoice
  has_one :interview
  has_one :conclusion, dependent: :destroy


  amoeba do
    enable
    recognize [:has_one]
  end

  def template
    unless task_text.nil?
      return 'task_text'
    end
    unless multichoice.nil?
      return 'multichoice'
    end
    unless interview.nil?
      return 'interview'
    end
    unless conclusion.nil?
      return 'conclusion'
    end
  end

  def set_level
    unless task.nil?
      highest_level = task.subtasks.maximum("level")
      unless highest_level.nil?
        update(level:highest_level + 1)
      else
        update(level:1)
      end
    else
      update(level:1)
    end
  end

  def update_levels_before_deleting
    unless task.nil?
      current_level = level
      other_subtasks = task.subtasks.where("level > ?", current_level)
      unless other_subtasks.empty?
        other_subtasks.each{ |current_subtask| current_subtask.update(level:(current_subtask.level - 1)) }
      end
    end
  end

  def move_down(new_level)
    unless task.nil?
      current_level = level
      other_subtasks = task.subtasks.where("level > ? and level <= ?", current_level, new_level)
      unless other_subtasks.empty?
        other_subtasks.each{ |current_subtask| current_subtask.update(level:(current_subtask.level - 1)) }
      end
    end
    update(level:new_level)
  end

  def move_up(new_level)
    unless task.nil?
      current_level = level
      other_subtasks = task.subtasks.where("level < ? and level >= ?", current_level, new_level)
      unless other_subtasks.empty?
        other_subtasks.each{ |current_subtask| current_subtask.update(level:(current_subtask.level + 1)) }
      end
    end
    update(level:new_level)
  end


  def to_s
    full_sanitizer = Rails::Html::FullSanitizer.new
    return_string = ''
    content = ''

    unless task_text.nil?
      return_string = task_text.to_s + ': '
      content = ActionController::Base.helpers.sanitize(full_sanitizer.sanitize(task_text.content.strip))
    end

    unless multichoice.nil?
      return_string = multichoice.to_s + ': '
      content = multichoice.question
    end

    unless interview.nil?
      return_string = interview.to_s + ': '
      content = interview.title
    end

    unless conclusion.nil?
      return_string = conclusion.to_s + ': '
      content = conclusion.title
    end

    if content.split.size > 3
      return_string += content.split[0...3].join(' ') + ' ...'
    else
      return_string += content
    end

    return return_string
  end
end
