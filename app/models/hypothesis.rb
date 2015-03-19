class Hypothesis < ActiveRecord::Base
  default_scope { order('name ASC') }

	validates :name, presence: true, uniqueness: true

	has_many :exercise_hypotheses, dependent: :destroy
	has_many :exercises, through: :exercise_hypotheses
  belongs_to :hypothesis_group
end
