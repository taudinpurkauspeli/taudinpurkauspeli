class Interview < ActiveRecord::Base
	validates :title, presence: true

	belongs_to :subtask
	has_many :questions, dependent: :destroy

	
end
