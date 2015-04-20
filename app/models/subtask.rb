class Subtask < ActiveRecord::Base
  after_create :set_level

  belongs_to :task

  has_one :task_text, dependent: :destroy
  has_one :multichoice, dependent: :destroy
  has_one :interview, dependent: :destroy
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

  def to_s
    full_sanitizer = Rails::Html::FullSanitizer.new
    return_string = 'Alakohta'
    content = ''

    unless task_text.nil?
      return_string = "Teksti: "
      content = full_sanitizer.sanitize(task_text.content.strip)
    end

    unless multichoice.nil?
      return_string = 'Monivalintakysymys: '
      content = multichoice.question
    end

    unless interview.nil?
      return_string = ''
      content = interview.title
    end

    unless conclusion.nil?
      return_string = ''
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
