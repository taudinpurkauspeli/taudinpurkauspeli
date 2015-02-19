class HypothesisGroup < ActiveRecord::Base

  default_scope { order('name ASC') }

  validates :name, presence: true, uniqueness: true
	has_many :hypotheses
end
