class CompletedTask < ActiveRecord::Base
  validates :task_id, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :task

  has_one :exercise, through: :task

  def has_exercise?(exercisee)
  	if exercise.id == exercisee.id
  		return true
  	end
  	return false
  end
end
