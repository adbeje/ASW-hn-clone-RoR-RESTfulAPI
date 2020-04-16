class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :contribucion
    acts_as_votable
end
