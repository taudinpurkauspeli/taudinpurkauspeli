class Option < ActiveRecord::Base
	validates :value, presence: true
	validates :content, presence: true
	validates :explanation, presence: true


	belongs_to :multichoice
end
