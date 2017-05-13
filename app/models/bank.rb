class Bank < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 2}, uniqueness: true

  has_many :titles, dependent: :destroy

end
