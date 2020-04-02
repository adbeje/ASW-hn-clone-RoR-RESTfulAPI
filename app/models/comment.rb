class Comment < ApplicationRecord
    belongs_to :contribucion
    has_one :user
end
