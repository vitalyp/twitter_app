class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet
  acts_as_likeable
  acts_as_paranoid
end
