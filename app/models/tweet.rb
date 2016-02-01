class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments

  acts_as_likeable
  acts_as_followable
  acts_as_paranoid

end
