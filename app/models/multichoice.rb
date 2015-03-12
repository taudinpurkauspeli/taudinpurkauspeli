class Multichoice < ActiveRecord::Base
	validates :question, presence: true

	belongs_to :subtask
	has_many :options, dependent: :destroy
end
