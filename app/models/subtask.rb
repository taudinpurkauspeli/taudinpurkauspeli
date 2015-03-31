class Subtask < ActiveRecord::Base
  validates :task_id, presence: true
  after_create :set_level

  belongs_to :task

  has_one :task_text, dependent: :destroy
  has_one :multichoice, dependent: :destroy
  has_one :interview, dependent: :destroy

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
  end

  def set_level
    highest_level = task.subtasks.maximum("level")
    unless highest_level.nil?
      update(level:highest_level + 1)
    else
      update(level:1)
    end
  end

  def to_s
    return_string = 'Alitoimenpide'
    content = ''

    unless task_text.nil?
      return_string = 'Teksti: '
      content = task_text.content
    end

    unless multichoice.nil?
      return_string = 'Monivalintakysymys: '
      content = multichoice.question
    end

    unless interview.nil?
      return_string = ''
      content = interview.title
    end

    if content.split.size > 3
      return_string += content.split[0...3].join(' ') + ' ...'
    else
      return_string += content
    end

    return return_string
  end
end
