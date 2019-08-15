class SavedExercise < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise

  validates :exercise_id, presence: true
  validates :user_id, presence: true
  validates :completion_percent, presence: true


end
