class Micropost < ApplicationRecord
  belongs_to :user
  #The micropost can't be blank
  validates :content, length: { maximum: 140 } ,
                                presence: true
end
