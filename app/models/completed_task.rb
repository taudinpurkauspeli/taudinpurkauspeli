class CompletedTask < ActiveRecord::Base
  validates :task_id, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :task

  has_one :exercise, through: :task
end
