class Book < ActiveRecord::Base
  validates :name, presence: true
end
