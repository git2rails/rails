class App < ActiveRecord::Base
  acts_as_commentable :friend, :raking
end
