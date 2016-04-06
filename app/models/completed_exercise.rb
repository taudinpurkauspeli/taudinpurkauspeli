class CompletedExercise < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise

  validate :cannot_complete_same_exercise_many_times

  def cannot_complete_same_exercise_many_times

    if user_id.present? && exercise_id.present?
      how_many_completed_exercises = CompletedExercise.where(user_id: user_id, exercise_id: exercise_id)
      if how_many_completed_exercises.count > 0
        errors.add(:base, 'User has already completed this exercise')
      end
    end
  end

end

