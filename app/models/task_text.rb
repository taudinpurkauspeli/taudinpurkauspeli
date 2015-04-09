class TaskText < ActiveRecord::Base
  validates :content, presence: true
    # Validate the attached image is image/jpg, image/png, etc

  belongs_to :subtask

  has_attached_file :picture, styles: {
    full: '1070>',
    thumb: '100x100#'
  }
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  amoeba do
    enable
  end

  def user_answered_correctly?(user)
    user.complete_subtask(subtask)
    return true
  end
end
