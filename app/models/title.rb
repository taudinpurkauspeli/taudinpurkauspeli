class Title < ActiveRecord::Base
  validates :text, presence: true, length: {minimum: 2}

  belongs_to :bank
  has_many :questions

end
