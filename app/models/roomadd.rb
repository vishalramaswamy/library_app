class Roomadd < ActiveRecord::Base
  belongs_to :user
  validates :room_no,presence: true,:uniqueness => true
  validates :size,presence: true
  validates :location,presence: true

end
