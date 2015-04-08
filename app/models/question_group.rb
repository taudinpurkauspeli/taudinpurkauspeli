class QuestionGroup < ActiveRecord::Base

	validates :title, presence: true

	has_many :questions, dependent: :destroy
end
