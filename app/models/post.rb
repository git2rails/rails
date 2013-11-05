class Post < ActiveRecord::Base
  acts_as_commentable
  belongs_to :user
  belongs_to :app
end
