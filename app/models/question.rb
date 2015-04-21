class Question < ActiveRecord::Base
	validates :title, presence: true
	validates :content, presence: true

	belongs_to :interview
	belongs_to :question_group
    belongs_to :image

    attr_accessor :question_group_title

	enum required: %i(allowed required wrong)

	amoeba do
		enable
	end

end
