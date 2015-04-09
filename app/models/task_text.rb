class TaskText < ActiveRecord::Base
  validates :content, presence: true
    # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/


  belongs_to :subtask

  has_attached_file :picture, styles: {
    full: '1070>'
  }


  amoeba do
    enable
  end




  def user_answered_correctly?(user)
    user.complete_subtask(subtask)
    return true
  end
end
