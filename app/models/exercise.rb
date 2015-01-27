class Exercise < ActiveRecord::Base
	has_many :tasks
	has_many :hypotheses
end
