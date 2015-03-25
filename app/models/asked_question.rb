class AskedQuestion < ActiveRecord::Base
  validates :user_id, presence: true
  validates :question_id, presence: true

	belongs_to :user
	belongs_to :question
end
