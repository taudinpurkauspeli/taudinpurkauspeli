class TaskText < ActiveRecord::Base
  validates :content, presence: true

  belongs_to :subtask, dependent: :destroy

  amoeba do
    enable
  end

  def user_answered_correctly?(user)
    user.complete_subtask(subtask)
    return true
  end

  def to_s
    'Teksti'
  end
end
