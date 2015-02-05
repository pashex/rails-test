class Book < ActiveRecord::Base
  validates :name, :release_date, presence: true
end
