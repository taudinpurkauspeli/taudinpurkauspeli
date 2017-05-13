class Title < ActiveRecord::Base
  validates :title, presence: true, length: {minimum: 2}

  belongs_to :bank

end
