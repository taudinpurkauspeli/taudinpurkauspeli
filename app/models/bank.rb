class Bank < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 2}

  has_many :titles, dependent: :destroy

end
