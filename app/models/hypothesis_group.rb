class HypothesisGroup < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
	has_many :hypotheses
end
