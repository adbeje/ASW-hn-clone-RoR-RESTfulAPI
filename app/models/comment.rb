class Comment < ApplicationRecord
    belongs_to  :user
    belongs_to  :contribucion
    has_many    :replies
    acts_as_votable
end
