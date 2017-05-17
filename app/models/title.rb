class Title < ActiveRecord::Base
  default_scope { order('text ASC') }

  validates :text, presence: true, length: {minimum: 2}

  belongs_to :bank
  has_many :questions, dependent: :destroy

end
