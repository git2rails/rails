class Post < ActiveRecord::Base
  has_many :comment
  belongs_to :user
  belongs_to :app
end
