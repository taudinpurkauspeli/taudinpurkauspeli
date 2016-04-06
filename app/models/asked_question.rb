class AskedQuestion < ActiveRecord::Base
  validates :user_id, presence: true
  validates :question_id, presence: true
  validate :cannot_ask_same_question_many_times

  belongs_to :user
	belongs_to :question

  def cannot_ask_same_question_many_times

    if user_id.present? && question_id.present?
      how_many_asked_questions = AskedQuestion.where(user_id: user_id, question_id: question_id)
      if how_many_asked_questions.count > 0
        errors.add(:base, 'User has already asked this question')
      end
    end
  end

end
