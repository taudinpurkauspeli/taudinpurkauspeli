class TaskText < ActiveRecord::Base
  validates :content, presence: true
    # Validate the attached image is image/jpg, image/png, etc

  belongs_to :subtask
  belongs_to :image

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
