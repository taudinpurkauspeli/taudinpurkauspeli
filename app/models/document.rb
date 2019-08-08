class Document < ActiveRecord::Base

  validates :name, presence: true, length: {minimum: 2}

  has_one_attached :data

end
