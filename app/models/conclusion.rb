class Conclusion < ActiveRecord::Base
	 belongs_to :subtask

	 belongs_to :exercise_hypothesis
end
